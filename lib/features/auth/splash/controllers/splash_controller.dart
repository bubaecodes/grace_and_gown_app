import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    );

    animationController.forward();

    Future.delayed(
        Duration(seconds: 6),
            (){

          /// to Close keyboard before navigating
          FocusManager.instance.primaryFocus?.unfocus();

          /// Where the app lands depends on how far the user got last time:
          /// never seen onboarding → onboarding; signed in → straight to the
          /// dashboard; otherwise → login. A fresh install (or a test, where
          /// prefs are untouched) reads both flags as false and still gets
          /// the onboarding hand-off.
          if (!AppStorage.seenOnboarding) {
            Get.offAllNamed(Routes.onboardingScreen);
          } else if (AppStorage.isLoggedIn) {
            Get.offAllNamed(Routes.dashboardScreen);
          } else {
            Get.offAllNamed(Routes.loginScreen);
          }
        }
    );

    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}