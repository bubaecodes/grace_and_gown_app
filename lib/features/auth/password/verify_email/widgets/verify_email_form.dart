import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_otp_field.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/features/auth/password/verify_email/controllers/verify_email_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class VerifyEmailForm extends StatelessWidget {
  const VerifyEmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification Code',
            style: (Theme.of(context).textTheme.bodyMedium ??
                const TextStyle())
                .copyWith(
              color: AppColors.grey,
              fontSize: 15.4.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          AppOtpField(
            controller: controller.codeController,
            autofocus: true,
          ),
          SizedBox(height: 20.h),

          Obx(
                () => AppPrimaryButton(
              text: 'Verify Email',
              isLoading: controller.isLoading.value,
              onTap: controller.verifyEmail,
            ),
          ),
          SizedBox(height: 14.h),

          Center(
            child: Obx(() {
              final secs = controller.secondsRemaining.value;
              final canResend = secs == 0;
              return Text.rich(
                TextSpan(
                  text: AppTexts.signupVerifyEmailFooter1,
                  style: (Theme.of(context).textTheme.bodySmall ??
                      const TextStyle())
                      .copyWith(
                    color: AppColors.grey,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    if (!canResend)
                      TextSpan(
                        text:
                        '${AppTexts.signupVerifyEmailFooter2}$secs s',
                      )
                    else
                      TextSpan(
                        text: 'Resend now',
                        style: (Theme.of(context)
                            .textTheme
                            .bodySmall ??
                            const TextStyle())
                            .copyWith(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.resendEmail,
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}