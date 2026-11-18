import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:grace_and_gown_app/features/auth/login/screens/login_screen.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final LiquidController liquidController = LiquidController();

  final currentPageIndex = 0.obs;

  void updatePageIndicator(int page) {
    currentPageIndex.value = page;
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      FocusManager.instance.primaryFocus?.unfocus();
      // Leaving onboarding for good — remember it so the next launch goes
      // straight to login (or the dashboard, if the session is still warm).
      AppStorage.seenOnboarding = true;
      Get.off(() => const LoginScreen());
    } else {
      liquidController.animateToPage(
        page: currentPageIndex.value + 1,
      );
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      liquidController.animateToPage(
        page: currentPageIndex.value - 1,
      );
    }
  }

  void skipPage() {
    liquidController.jumpToPage(page: 2);
  }
}
