import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/auth/password/verify_email/controllers/verify_email_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class VerifyEmailHeader extends StatelessWidget {
  const VerifyEmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Column(
      children: [
        Text(
          AppTexts.signupVerifyEmailHeader,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Prata',
            fontSize: 28.sp,
            letterSpacing: 1.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.heading(context),
          ),
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Obx(
                () => Text.rich(
              TextSpan(
                text: AppTexts.signupVerifyEmailSubHeader1,
                style: (Theme.of(context).textTheme.bodyMedium ??
                    const TextStyle())
                    .copyWith(
                  color: AppColors.secondary(context),
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: controller.email.value,
                    style: (Theme.of(context).textTheme.bodyMedium ??
                        const TextStyle())
                        .copyWith(
                      color: AppColors.accentText(context),
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: AppTexts.signupVerifyEmailSubHeader2),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}