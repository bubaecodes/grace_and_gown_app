import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/features/auth/password/reset_link/controllers/reset_link_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class ResetLinkForm extends StatelessWidget {
  const ResetLinkForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetLinkController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text.rich(
              TextSpan(
                text: AppTexts.passwordResetLinkSubHeader1,
                style: (Theme.of(context).textTheme.bodyMedium ??
                    const TextStyle())
                    .copyWith(
                  color: AppColors.grey,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: controller.email.value,
                    style: (Theme.of(context).textTheme.bodyMedium ??
                        const TextStyle())
                        .copyWith(
                      color: AppColors.primaryGreen,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: AppTexts.passwordResetLinkSubHeader2),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          AppPrimaryButton(
            text: AppTexts.passwordResetLinkBtnText,
            onTap: controller.openEmailApp,
          ),
          SizedBox(height: 16.h),

          Center(
            child: Obx(() {
              final secs = controller.secondsRemaining.value;
              final canResend = secs == 0;
              return GestureDetector(
                onTap: canResend ? controller.resendEmail : null,
                child: Text.rich(
                  TextSpan(
                    text: AppTexts.passwordResetLinkFooter,
                    style: (Theme.of(context).textTheme.bodySmall ??
                        const TextStyle())
                        .copyWith(
                      color: canResend
                          ? AppColors.primaryGreen
                          : AppColors.grey,
                      fontSize: 13.5.sp,
                      fontWeight:
                      canResend ? FontWeight.w700 : FontWeight.w500,
                    ),
                    children: [
                      if (!canResend)
                        TextSpan(
                          text: ' ($secs s)',
                          style: (Theme.of(context)
                              .textTheme
                              .bodySmall ??
                              const TextStyle())
                              .copyWith(
                            color: AppColors.darkSageGreen,
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}