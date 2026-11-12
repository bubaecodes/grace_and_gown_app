import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/auth/password/confirm_password/widgets/reset_complete_sheet.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class ConfirmPasswordController extends GetxController {
  static ConfirmPasswordController get instance => Get.find();

  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isNewVisible = false.obs;
  RxBool isConfirmVisible = false.obs;
  RxBool isLoading = false.obs;

  void toggleNewPassword() => isNewVisible.toggle();
  void toggleConfirmPassword() => isConfirmVisible.toggle();

  Future<void> resetPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (codeController.text.length != 6) {
      CustomSnackBar.showSafe(
        title: 'Missing Code',
        message: 'Enter the 6-digit code from your email.',
        type: ToastificationType.error,
      );
      return;
    }

    if (newPasswordController.text.length < 6) {
      CustomSnackBar.showSafe(
        title: 'Weak Password',
        message: 'Password must be at least 6 characters long.',
        type: ToastificationType.error,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      CustomSnackBar.showSafe(
        title: 'Password Mismatch',
        message: 'The passwords you entered do not match.',
        type: ToastificationType.error,
      );
      return;
    }

    isLoading.value = true;
    /// TODO: replace with a real backend call, e.g.
    /// FirebaseAuth.instance.confirmPasswordReset(...)
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    await ResetCompleteSheet.show();
  }

  @override
  void onClose() {
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}