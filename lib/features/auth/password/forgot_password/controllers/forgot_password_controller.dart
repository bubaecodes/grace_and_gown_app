import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> sendResetLink() async {
    /// Close keyboard before navigating
    FocusManager.instance.primaryFocus?.unfocus();

    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      CustomSnackBar.showSafe(
        title: 'Invalid Email',
        message: 'Please enter a valid email address.',
        type: ToastificationType.error,
      );
      return;
    }

    isLoading.value = true;
    /// TODO: replace with a real backend call, e.g.
    /// FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    CustomSnackBar.showSafe(
      title: 'Reset Link Sent',
      message: 'Check your inbox for the password reset link.',
      type: ToastificationType.success,
    );

    Get.toNamed(Routes.resetLinkScreen, arguments: email);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}