import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/features/wishlist/screens/wishlist_screen.dart';

Future<void> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(home: const DashboardScreen()),
    ),
  );
}

/// Products live in both the Home tab and the Wishlist tab once favourited,
/// so scope finds to the wishlist to keep assertions exact.
///
/// The dashboard's `IndexedStack` parks unselected tabs offstage, and
/// `find.descendant` evaluates the inner finder from the root with that
/// finder's own `skipOffstage` — so both sides have to opt out of it.
Finder _onWishlistText(String text) => find.descendant(
      of: find.byType(WishlistScreen, skipOffstage: false),
      matching: find.text(text, skipOffstage: false),
      skipOffstage: false,
    );

/// GetX singletons outlive each testWidgets body (the container is global),
/// so state built up in one test would leak into the next.
void _resetSessionState() {
  Get.delete<WishlistController>();
  Get.delete<DashboardController>();
}

void main() {
  testWidgets('hearting a card makes the gown appear on the wishlist tab',
      (tester) async {
    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    // Nothing saved yet, so the wishlist shows its empty state.
    expect(_onWishlistText('No favorites yet'), findsOneWidget);

    // Heart the first product card on the home grid.
    await tester.tap(find.byIcon(Icons.favorite_outline_rounded).first);
    await tester.pump();

    // The card's own heart fills in.
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

    // Switch to the wishlist tab.
    // `.last` picks the bottom-nav label over the screen's header.
    await tester.tap(find.text('Wishlist').last);
    await tester.pumpAndSettle();

    // The saved gown is now rendered by the wishlist grid, and the empty
    // state is gone.
    expect(_onWishlistText('Aurelia Lace Gown'), findsOneWidget);
    expect(_onWishlistText('No favorites yet'), findsNothing);
  });

  testWidgets('un-hearting a card removes it from the wishlist tab',
      (tester) async {
    _resetSessionState();

    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    // Save a gown, then confirm it lands on the wishlist.
    await tester.tap(find.byIcon(Icons.favorite_outline_rounded).first);
    await tester.pump();
    await tester.tap(find.text('Wishlist').last);
    await tester.pumpAndSettle();
    expect(_onWishlistText('Aurelia Lace Gown'), findsOneWidget);

    // Back to home, un-heart the same card.
    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_rounded).first);
    await tester.pump();

    // Return to the wishlist, and the empty state is back.
    await tester.tap(find.text('Wishlist').last);
    await tester.pumpAndSettle();
    expect(_onWishlistText('Aurelia Lace Gown'), findsNothing);
    expect(_onWishlistText('No favorites yet'), findsOneWidget);
  });
}
