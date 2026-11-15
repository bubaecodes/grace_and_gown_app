import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

/// How the client settles the booking fee.
enum PaymentMethod {
  card,
  bankTransfer,
  ussd,
}

/// Drives the ₦20,000 booking-fee checkout.
///
/// This is a mock: there is no gateway in the app yet, so [pay] simulates
/// a short processing window and then hands a generated reference to
/// [BookingsController.finalizeBooking] — exactly where a real gateway's
/// success callback would land. Swapping in Paystack/Flutterwave later
/// means replacing the body of [pay] and nothing else.
class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  /// The fee being collected, kept in one place so the screen and the
  /// booking sheet never drift apart.
  static String get fee => BookingsController.bookingFee;

  /// Selected method. Defaults to card, the usual first choice.
  final Rx<PaymentMethod> method = PaymentMethod.card.obs;

  /// True while the mock charge is running — drives the button spinner.
  final RxBool isProcessing = false.obs;

  /// True once the fee settled and the booking exists. The screen swaps
  /// to its success state.
  final RxBool isPaid = false.obs;

  /// Reference returned for the settled charge, e.g. `PAY-8341`.
  final Rx<String?> paymentReference = Rx<String?>(null);

  // --- Card form state ---
  //
  // Lives here rather than in the screen so the checkout survives any
  // rebuild (switching method, showing errors) without losing input.

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cardExpiry = TextEditingController();
  final TextEditingController cardCvv = TextEditingController();
  final TextEditingController cardName = TextEditingController();

  /// Runs the card field validators. False means "show the errors, don't
  /// charge".
  bool validateCard() => formKey.currentState?.validate() ?? false;

  @override
  void onClose() {
    cardNumber.dispose();
    cardExpiry.dispose();
    cardCvv.dispose();
    cardName.dispose();
    super.onClose();
  }

  static int _paySeq = 8340;

  void select(PaymentMethod next) {
    if (isProcessing.value) return;
    method.value = next;
  }

  /// Simulate the charge, then create the booking.
  ///
  /// Returns false when a charge is already in flight or there is nothing
  /// to pay for (the sheet's picks were cleared or never made).
  Future<bool> pay() async {
    if (isProcessing.value) return false;

    final bookings = BookingsController.instance;
    if (!bookings.canConfirm) {
      CustomSnackBar.showSafe(
        title: 'Nothing to Pay For',
        message: 'Pick a day and time for your fitting first.',
        type: ToastificationType.warning,
      );
      return false;
    }

    isProcessing.value = true;

    // Stand-in for the gateway round-trip.
    await Future.delayed(const Duration(milliseconds: 1600));

    final reference = 'PAY-${++_paySeq}';
    paymentReference.value = reference;

    // The booking only exists because the payment succeeded.
    bookings.finalizeBooking(paymentReference: reference);

    isProcessing.value = false;
    isPaid.value = true;

    CustomSnackBar.showSafe(
      title: 'Payment Successful',
      message: '$fee paid · $reference',
      type: ToastificationType.success,
    );

    return true;
  }

  /// Leave the checkout without paying. Picks stay intact, so the client
  /// can walk back into the sheet and try again.
  void cancel() {
    if (isProcessing.value) return;
    Get.back();
  }

  /// Success state → back to the bookings tab.
  void done() => Get.back();

  /// Fresh state for the next checkout. The screen calls this in `onInit`
  /// so a previous attempt never shows as already-paid.
  void reset() {
    isProcessing.value = false;
    isPaid.value = false;
    paymentReference.value = null;
    method.value = PaymentMethod.card;
  }
}
