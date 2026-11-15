import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/payment_controller.dart';
import 'package:grace_and_gown_app/features/bookings/screens/bookings_screen.dart';
import 'package:grace_and_gown_app/features/bookings/screens/payment_screen.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/routes/app_pages.dart';
import 'package:toastification/toastification.dart';

Future<void> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    // The app wraps itself in this (see main_app.dart); the confirm
    // toast raised by the booking sheet needs it too.
    ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: const Size(440, 976),
        minTextAdapt: true,
        splitScreenMode: true,
        // The real app registers these (main_app.dart); without them
        // `Get.toNamed(Routes.paymentScreen)` has no route to push.
        builder: (_, _) => GetMaterialApp(
          getPages: AppPages.pages,
          home: const DashboardScreen(),
        ),
      ),
    ),
  );
}

/// GetX singletons outlive each testWidgets body, so state built up in one
/// test would leak into the next.
void _resetSessionState() {
  Get.delete<BookingsController>();
  Get.delete<PaymentController>();
  Get.delete<WishlistController>();
  Get.delete<DashboardController>();
}

/// Scopes a text find to the bookings tab. The dashboard's `IndexedStack`
/// parks unselected tabs offstage, and `find.descendant` evaluates the
/// inner finder from the root with that finder's own `skipOffstage` — so
/// both sides have to opt out of it.
Finder _onBookingsText(String text) => find.descendant(
      of: find.byType(BookingsScreen, skipOffstage: false),
      matching: find.text(text, skipOffstage: false),
      skipOffstage: false,
    );

/// Switches tabs via the bottom nav. `.last` picks the nav label over any
/// same-named screen header.
Future<void> _goToTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('bookings tab shows the seeded fitting and try-on list',
      (tester) async {
    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    await _goToTab(tester, 'Bookings');

    // The seeded booking renders with its details.
    expect(_onBookingsText('Bridal Fitting'), findsOneWidget);
    expect(_onBookingsText('Confirmed'), findsOneWidget);
    expect(_onBookingsText('GG-1042'), findsOneWidget);
    expect(
      _onBookingsText('Grace & Gown Studio, Lekki Phase 1'),
      findsOneWidget,
    );

    // Booking actions and the try-on section are present.
    expect(find.text('Book a Fitting'), findsOneWidget);
    expect(_onBookingsText('TRY-ON LIST'), findsOneWidget);

    // The seeded visit was paid for, so the card shows it.
    expect(_onBookingsText('PAID'), findsOneWidget);

    // Nothing hearted yet, so the try-on list shows its empty state.
    expect(_onBookingsText('Nothing saved yet'), findsOneWidget);
  });

  testWidgets('a booking only exists once the ₦20,000 fee is paid',
      (tester) async {
    _resetSessionState();

    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));
    await _goToTab(tester, 'Bookings');

    // Open the sheet. The button refuses to advance until both picks.
    await tester.tap(find.text('Book a Fitting'));
    await tester.pumpAndSettle();

    expect(find.text('SELECT A DAY'), findsOneWidget);
    expect(find.text('Pick a Day and Time'), findsOneWidget);

    // Pick the first offered day, then the "2:00 PM" slot.
    await tester.tap(find.byKey(const ValueKey('booking-day-0')));
    await tester.pump();
    await tester.tap(find.text('2:00 PM'));
    await tester.pump();

    await tester.tap(find.text('Continue to Payment · ${BookingsController.bookingFee}'));
    await tester.pumpAndSettle();

    // Sheet closed, checkout open — and still no booking, because the
    // fee hasn't settled yet.
    expect(find.byType(PaymentScreen), findsOneWidget);
    expect(find.text('SELECT A DAY'), findsNothing);
    expect(_onBookingsText('Fitting Rescheduled'), findsNothing);

    // Card details are validated before anything is charged.
    await tester.tap(find.text('Pay ${BookingsController.bookingFee}'));
    await tester.pump();
    expect(find.text('Enter your card number'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '4084084084084081');
    await tester.enterText(fields.at(1), '12/28');
    await tester.enterText(fields.at(2), '408');
    await tester.enterText(fields.at(3), 'GRACE OKON');
    await tester.pump();

    // Charge runs — the button turns into a spinner while it does.
    await tester.tap(find.text('Pay ${BookingsController.bookingFee}'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Pay ${BookingsController.bookingFee}'), findsNothing);

    // Stand-in for the gateway round-trip (1600ms in the controller).
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pumpAndSettle();

    // Settled: success state with a reference, booking now exists & paid.
    expect(find.text('Payment Successful'), findsOneWidget);
    expect(find.textContaining('Ref PAY-'), findsOneWidget);

    await tester.tap(find.text('Back to Bookings'));
    await tester.pumpAndSettle();

    expect(_onBookingsText('Fitting Rescheduled'), findsOneWidget);
    expect(_onBookingsText('PAID'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(BookingsScreen, skipOffstage: false),
        matching: find.textContaining('paid · PAY-', skipOffstage: false),
        skipOffstage: false,
      ),
      findsOneWidget,
    );
  });

  testWidgets('a favorited gown lands on the try-on list', (tester) async {
    _resetSessionState();

    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    // Heart the first card on the home grid, then come back to bookings.
    await tester.tap(find.byIcon(Icons.favorite_outline_rounded).first);
    await tester.pump();
    await _goToTab(tester, 'Bookings');

    expect(_onBookingsText('Aurelia Lace Gown'), findsOneWidget);
    expect(_onBookingsText('Nothing saved yet'), findsNothing);

    // Un-hearting it from the list itself empties the section again.
    await tester.tap(
      find
          .descendant(
            of: find.byType(BookingsScreen),
            matching: find.byIcon(Icons.favorite_rounded),
          )
          .first,
    );
    await tester.pump();

    expect(_onBookingsText('Aurelia Lace Gown'), findsNothing);
    expect(_onBookingsText('Nothing saved yet'), findsOneWidget);
  });
}
