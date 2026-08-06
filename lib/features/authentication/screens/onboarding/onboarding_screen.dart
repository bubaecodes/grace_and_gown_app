import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grace_and_gown_app/features/authentication/screens/onboarding/widgets/onboarding_next_btn.dart';
import 'package:grace_and_gown_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:grace_and_gown_app/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25 - 5),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnboardingPage(
                  image: AppImages.onboardingScreenImg1,
                  title: AppTexts.onBoardingTitle1,
                  subtitle: AppTexts.onBoardingSubTitle1,
                ),
                OnboardingPage(
                  image: AppImages.onboardingScreenImg2,
                  title: AppTexts.onBoardingTitle2,
                  subtitle: AppTexts.onBoardingSubTitle2,
                ),
                OnboardingPage(
                  image: AppImages.onboardingScreenImg3,
                  title: AppTexts.onBoardingTitle3,
                  subtitle: AppTexts.onBoardingSubTitle3,
                ),
              ],
            ),
            OnBoardingSkip(),
            OnBoardingNextButton(),
          ],
        ),
      ),
    );
  }
}
