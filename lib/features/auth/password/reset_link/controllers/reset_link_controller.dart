import 'dart:async';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class ResetLinkController extends GetxController {
  static ResetLinkController get instance => Get.find();

  RxString email = 'your email'.obs;
  RxInt secondsRemaining = 30.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is String && args.isNotEmpty) {
      email.value = args;
    }

    startResendCountdown();
  }

  void startResendCountdown({int seconds = 30}) {
    _timer?.cancel();
    secondsRemaining.value = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value <= 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendEmail() {
    if (secondsRemaining.value > 0) return;

    /// TODO: call the backend to resend the reset link
    CustomSnackBar.showSafe(
      title: 'Email Resent',
      message: 'We sent a new reset link to ${email.value}.',
      type: ToastificationType.success,
    );

    startResendCountdown();
  }

  void openEmailApp() {
    /// TODO: use url_launcher to open the user's mail app
    CustomSnackBar.showSafe(
      title: 'Opening Mail',
      message: 'Redirecting you to your email app...',
      type: ToastificationType.info,
    );

    /// In production this screen is reached from the email deep link and
    /// the confirm-password step follows automatically. For now we walk
    /// the flow forward manually.
    Get.toNamed(
      Routes.confirmPasswordScreen,
      arguments: email.value,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}