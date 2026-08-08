import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;

    return Positioned(
      left: 22.w,
      right: 22.w,
      bottom: 40.h,
      child: SizedBox(
        height: 0.071.sh,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.nextPage(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.sageGreen,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(33),
              side: BorderSide(color: AppColors.darkSageGreen),
            ),
          ),
          child: Obx(() => Text(
            controller.currentPageIndex < 2 ? 'Next' : 'Login',
            style: (Theme.of(context).textTheme.labelSmall ?? const TextStyle())
                .copyWith(color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}