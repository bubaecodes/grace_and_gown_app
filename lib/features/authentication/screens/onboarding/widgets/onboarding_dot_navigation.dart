import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: 3,
            onDotClicked: controller.dotNavigationClick,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primaryGreen,
              dotHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}