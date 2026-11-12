import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/auth/onboarding/controllers/onboarding_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDeviceUtils.getAppBarHeight(),
      left: 1.w,
      right: 1.w,
      child: SizedBox(
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Back button
            Obx(() {
              final controller = OnboardingController.instance;

              if (controller.currentPageIndex.value == 0) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primaryGreen,
                  size: 22.sp,
                ),
                onPressed: controller.previousPage,
              );
            }),

            /// Skip button
            Obx(() {
              final controller = OnboardingController.instance;

              if (controller.currentPageIndex.value == 2) {
                return const SizedBox.shrink();
              }

              return TextButton(
                onPressed: controller.skipPage,
                child: Text(
                  "Skip",
                  style: (Theme.of(context).textTheme.bodyMedium ??
                      const TextStyle())
                      .copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.darkGreen,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}