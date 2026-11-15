import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/payment_controller.dart';
import 'package:grace_and_gown_app/features/bookings/models/booking.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

/// State for the Bookings tab.
///
/// Holds the upcoming visit and the working selections for the booking
/// sheet. Everything is in-memory mock data — swap [upcoming] for a real
/// bookings source later and the screen keeps working unchanged.
///
/// Booking is a two-step flow: the sheet picks a day and slot (held in
/// [selectedDate]/[selectedTime], not yet a booking), then the payment
/// screen charges [bookingFee] and only on success calls
/// [finalizeBooking] to create the visit.
class BookingsController extends GetxController {
  static BookingsController get instance => Get.find();

  /// Fee charged to hold a fitting. Charged once per booking, before the
  /// booking exists.
  static const String bookingFee = '₦20,000';

  /// The visit currently on the books. Starts with a seeded mock so the
  /// screen reads like a real booking app from the first launch.
  final Rx<Booking?> upcoming = Booking(
    reference: 'GG-1042',
    date: DateTime.now().add(const Duration(days: 6)),
    time: '11:00 AM',
    style: 'Bridal Fitting',
    isPaid: true,
    paymentReference: 'PAY-77310',
  ).obs;

  // --- Booking sheet working state ---

  /// Day picked in the sheet. Null until the user chooses one.
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  /// Slot picked in the sheet. Null until the user chooses one.
  final Rx<String?> selectedTime = Rx<String?>(null);

  /// The next 14 days, today included — what the date row offers.
  List<DateTime> get availableDays => List.generate(14, (i) {
        final now = DateTime.now();
        return DateTime(now.year, now.month, now.day).add(Duration(days: i));
      });

  /// Fitting slots offered each day, in order.
  static const List<String> availableTimes = [
    '10:00 AM',
    '11:00 AM',
    '12:30 PM',
    '2:00 PM',
    '3:30 PM',
    '5:00 PM',
  ];

  bool get canConfirm =>
      selectedDate.value != null && selectedTime.value != null;

  /// Called each time the sheet opens, so stale picks never leak into the
  /// next booking.
  void openSheet() {
    selectedDate.value = null;
    selectedTime.value = null;
  }

  void pickDate(DateTime day) => selectedDate.value = day;

  void pickTime(String time) => selectedTime.value = time;

  /// Hand the picks over to the payment step. No booking exists yet —
  /// [finalizeBooking] creates it once the fee is paid.
  ///
  /// Returns false (and stays put) when nothing is picked.
  bool continueToPayment() {
    if (!canConfirm) return false;

    // Fresh checkout state — a previous attempt must never show as paid.
    Get.put(PaymentController()).reset();

    Get.toNamed(Routes.paymentScreen);
    return true;
  }

  /// Called by the payment screen on success. Creates the visit from the
  /// picks held in the sheet, marks it paid, then clears the picks.
  void finalizeBooking({required String paymentReference}) {
    final day = selectedDate.value;
    final time = selectedTime.value;
    if (day == null || time == null) return;

    final rescheduling = upcoming.value != null;

    upcoming.value = Booking(
      reference: 'GG-${++_referenceSeq}',
      date: day,
      time: time,
      style: rescheduling ? 'Fitting Rescheduled' : 'Bridal Fitting',
      isPaid: true,
      paymentReference: paymentReference,
    );

    selectedDate.value = null;
    selectedTime.value = null;

    CustomSnackBar.showSafe(
      title: rescheduling ? 'Booking Rescheduled' : 'Booking Confirmed',
      message:
          'Your fitting is set for ${formatDay(day)} at $time. $bookingFee paid.',
      type: ToastificationType.success,
    );
  }

  /// Drop the visit. Returns silently when there is nothing to cancel.
  void cancelBooking() {
    if (upcoming.value == null) return;

    upcoming.value = null;
    CustomSnackBar.showSafe(
      title: 'Booking Cancelled',
      message: 'Your fitting has been cancelled. Book a new slot any time.',
      type: ToastificationType.info,
    );
  }

  /// The gowns to pull off the rail first when the client walks in —
  /// straight from the shared wishlist, so un-hearting one here removes it.
  ///
  /// Reads the reactive set, so this is safe to call inside `Obx`.
  List<Product> get tryOnList => WishlistController.instance.favorites;

  /// Bumped per booking so each visit gets its own reference number.
  static int _referenceSeq = 1042;

  // --- Date formatting (no intl dependency in this project) ---

  static const List<String> _weekdays = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// `Sat, 21 Nov`
  static String formatDay(DateTime day) =>
      '${_weekdays[day.weekday - 1]}, ${day.day} ${_months[day.month - 1]}';

  /// `November 2026` — the sheet's month heading.
  static String formatMonth(DateTime day) {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${names[day.month - 1]} ${day.year}';
  }
}
