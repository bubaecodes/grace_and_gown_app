import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/authentication/screens/login/widgets/login_screen.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentPageIndex= 0.obs;

  /// update page index when scrolled
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// jump to the selected dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// jump to next page
  void nextPage(){
    if (currentPageIndex.value == 2) {
      FocusManager.instance.primaryFocus?.unfocus();

      Get.to(LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.jumpToPage(page);
    }
  }

  /// update current index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    FocusManager.instance.primaryFocus?.unfocus();
    pageController.jumpToPage(2);
  }
}