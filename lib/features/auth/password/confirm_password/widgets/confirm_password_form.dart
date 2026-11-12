import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_otp_field.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/auth/password/confirm_password/controllers/confirm_password_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class ConfirmPasswordForm extends StatelessWidget {
  const ConfirmPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmPasswordController());

    Widget label(String text) => Text(
      text,
      style: (Theme.of(context).textTheme.bodyMedium ??
          const TextStyle())
          .copyWith(
        color: AppColors.secondary(context),
        fontSize: 15.4.sp,
        fontWeight: FontWeight.w500,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label('6-Digit Code'),
          SizedBox(height: 6.h),
          AppOtpField(controller: controller.codeController),
          SizedBox(height: 14.h),

          label(AppTexts.confirmPasswordLabelTitle1),
          Obx(
            () => AppFormTextField(
              controller: controller.newPasswordController,
              hintText: 'Enter new password',
              prefixIcon: Icons.lock,
              obscureText: !controller.isNewVisible.value,
              suffixIcon: controller.isNewVisible.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              iconToggle: controller.toggleNewPassword,
            ),
          ),
          SizedBox(height: 5.h),

          label(AppTexts.confirmPasswordLabelTitle2),
          Obx(
            () => AppFormTextField(
              controller: controller.confirmPasswordController,
              hintText: 'Confirm new password',
              prefixIcon: Icons.lock,
              obscureText: !controller.isConfirmVisible.value,
              suffixIcon: controller.isConfirmVisible.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              iconToggle: controller.toggleConfirmPassword,
            ),
          ),
          SizedBox(height: 20.h),

          Obx(
                () => AppPrimaryButton(
              text: AppTexts.confirmPasswordFooterText,
              isLoading: controller.isLoading.value,
              onTap: controller.resetPassword,
            ),
          ),
        ],
      ),
    );
  }
}