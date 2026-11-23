import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';
import 'package:grace_and_gown_app/utils/validators/validation.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  RxBool isVisible = false.obs;

  void isToggle(){
    isVisible.toggle();
  }

  String? validateEmail(String? value) => AppValidator.validateEmail(value);

  /// Login only needs the password present and long enough — the strict
  /// uppercase/number/symbol rules belong to sign-up, not sign-in.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
    if (value.length < 6) return 'Password must be at least 6 characters long.';
    return null;
  }

  /// Validate the form, then enter the app. There is no backend yet, so any
  /// well-formed credentials are accepted — the validation keeps malformed
  /// input out and mirrors what a real check would do first.
  void login(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    // Warm session: the next launch skips straight to the dashboard.
    AppStorage.isLoggedIn = true;

    Get.offAllNamed(Routes.dashboardScreen);
  }
}
