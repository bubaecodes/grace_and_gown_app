import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:grace_and_gown_app/utils/validators/validation.dart';
import 'package:toastification/toastification.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Key for the Form widget in SignupForm
  final formKey = GlobalKey<FormState>();

  /// Field inputs
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// UI state
  RxBool isPwdVisible = false.obs;
  RxBool isConfirmPwdVisible = false.obs;
  RxBool isLoading = false.obs;

  void togglePassword() => isPwdVisible.toggle();
  void toggleConfirmPassword() => isConfirmPwdVisible.toggle();

  /// Validators (reusing your existing AppValidator)
  String? validateFullName(String? value) =>
      AppValidator.validateEmptyText('Full Name', value);

  String? validateEmail(String? value) =>
      AppValidator.validateEmail(value);

  String? validatePhone(String? value) =>
      AppValidator.validatePhoneNumber(value);

  String? validatePassword(String? value) =>
      AppValidator.validatePassword(value);

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password.';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  Future<void> signup() async {
    /// Close keyboard first
    FocusManager.instance.primaryFocus?.unfocus();

    /// Run every field's validator; stop if any failed
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    /// TODO: replace with a real backend call, e.g.
    /// FirebaseAuth.instance.createUserWithEmailAndPassword(...)
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    CustomSnackBar.showSafe(
      title: 'Account Created',
      message:
      'We sent a verification code to ${emailController.text.trim()}.',
      type: ToastificationType.success,
    );

    /// Pass the REAL typed email to the Verify Email screen
    Get.toNamed(
      Routes.verifyEmailScreen,
      arguments: emailController.text.trim(),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}