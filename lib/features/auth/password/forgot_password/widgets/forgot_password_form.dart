import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/controllers/forgot_password_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: (Theme.of(context).textTheme.bodyMedium ??
                const TextStyle())
                .copyWith(
              color: AppColors.grey,
              fontSize: 15.4.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppFormTextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: AppTexts.forgotPasswordHintText,
            prefixIcon: Icons.mail,
          ),
          SizedBox(height: 14.h),

          Obx(
                () => AppPrimaryButton(
              text: AppTexts.forgotPasswordBtn,
              isLoading: controller.isLoading.value,
              onTap: controller.sendResetLink,
            ),
          ),
          SizedBox(height: 14.h),

          Center(
            child: Text.rich(
              TextSpan(
                text: 'Remember your password? ',
                style: (Theme.of(context).textTheme.bodySmall ??
                    const TextStyle())
                    .copyWith(
                  color: AppColors.sageGreen,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: (Theme.of(context).textTheme.bodySmall ??
                        const TextStyle())
                        .copyWith(
                      color: AppColors.primaryGreen,
                      fontSize: 15.3.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Get.offAllNamed(Routes.loginScreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}