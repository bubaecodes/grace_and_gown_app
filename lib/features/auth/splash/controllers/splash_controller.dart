import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    print('splash showeddddd');

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

          Get.offAllNamed(Routes.onboardingScreen);
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