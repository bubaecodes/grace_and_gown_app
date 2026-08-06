import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;
    return Positioned(
      top: AppDeviceUtils.getAppBarHeight(),
      right: 1.w,
      left: 1.w,
      child: SizedBox(
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// back leading icon
            Obx(() {
              final controller = OnboardingController.instance;

              if (controller.currentPageIndex.value == 0) {
                return SizedBox.shrink();
              }

              return IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.darkGreen,),
                onPressed: () {
                  int prevPage = controller.currentPageIndex.value - 1;
                  controller.pageController.animateToPage(
                    prevPage,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              );
            }),

            /// skip btn
            Obx(
              () {
                final controller = OnboardingController.instance;

                if (controller.currentPageIndex.value == 2) {
                  return SizedBox.shrink();
                }

                return TextButton(
                  onPressed: () => controller.skipPage(),
                  child: Text(
                    "Skip",
                    style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
                        .copyWith(decoration: TextDecoration.underline, color: AppColors.darkGreen, fontSize: 18.sp, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                );
                }
            ),
          ],
        ),
      ),
    );
  }
}