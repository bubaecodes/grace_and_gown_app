import 'dart:async';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// Hands the user to their mail app so they can grab the code, then walks
  /// the flow forward to the code-entry step. Launching is best-effort —
  /// some devices have no mail app configured, which shouldn't strand the
  /// user on this screen.
  Future<void> openEmailApp() async {
    try {
      await launchUrl(
        Uri(scheme: 'mailto'),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      CustomSnackBar.showSafe(
        title: 'Opening Mail',
        message: 'We couldn\'t open a mail app on this device — '
            'check your inbox another way.',
        type: ToastificationType.info,
      );
    }

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