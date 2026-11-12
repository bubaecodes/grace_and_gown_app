import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final codeController = TextEditingController();
  RxString email = 'your email'.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool isLoading = false.obs;
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

  void startResendCountdown({int seconds = 60}) {
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

    /// TODO: call the backend to resend the verification code
    CustomSnackBar.showSafe(
      title: 'Code Resent',
      message: 'We sent a new code to ${email.value}.',
      type: ToastificationType.success,
    );

    startResendCountdown();
  }

  Future<void> verifyEmail() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (codeController.text.length != 6) {
      CustomSnackBar.showSafe(
        title: 'Missing Code',
        message: 'Enter the 6-digit code from your email.',
        type: ToastificationType.error,
      );
      return;
    }

    isLoading.value = true;
    /// TODO: replace with a real backend call, e.g.
    /// FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(...)
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    CustomSnackBar.showSafe(
      title: 'Email Verified',
      message: 'Your email has been verified successfully!',
      type: ToastificationType.success,
    );

    /// TODO: navigate to the dashboard once it's built
    /// Get.offAllNamed(Routes.dashboardScreen);
    Get.offAllNamed(Routes.loginScreen);
  }

  @override
  void onClose() {
    codeController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
