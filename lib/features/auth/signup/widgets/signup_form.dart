import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/auth/signup/controllers/signup_controller.dart';
import 'package:grace_and_gown_app/features/auth/signup/widgets/signup_footer.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

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
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 2.h),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label('Full Name'),
            AppFormTextField(
              controller: controller.fullNameController,
              validator: controller.validateFullName,
              textInputAction: TextInputAction.next,
              hintText: 'Enter your full name',
              prefixIcon: Icons.person_outline_rounded,
            ),
            SizedBox(height: 5.sp),

            label('Email'),
            AppFormTextField(
              controller: controller.emailController,
              validator: controller.validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: 'Enter your email',
              prefixIcon: Icons.mail,
            ),
            SizedBox(height: 5.sp),

            label('Phone Number'),
            AppFormTextField(
              controller: controller.phoneController,
              validator: controller.validatePhone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              hintText: 'Enter your phone number',
              prefixIcon: Icons.phone_outlined,
            ),
            SizedBox(height: 5.sp),

            label('Password'),
            Obx(
                  () => AppFormTextField(
                controller: controller.passwordController,
                validator: controller.validatePassword,
                textInputAction: TextInputAction.next,
                hintText: 'Create a password',
                prefixIcon: Icons.lock,
                obscureText: !controller.isPwdVisible.value,
                suffixIcon: controller.isPwdVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                onTap: controller.togglePassword,
              ),
            ),
            SizedBox(height: 5.sp),

            label('Confirm Password'),
            Obx(
                  () => AppFormTextField(
                controller: controller.confirmPasswordController,
                validator: controller.validateConfirmPassword,
                textInputAction: TextInputAction.done,
                hintText: 'Confirm your password',
                prefixIcon: Icons.lock,
                obscureText: !controller.isConfirmPwdVisible.value,
                suffixIcon: controller.isConfirmPwdVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                onTap: controller.toggleConfirmPassword,
              ),
            ),
            SizedBox(height: 14.h),

            Obx(
                  () => AppPrimaryButton(
                text: 'Sign Up',
                isLoading: controller.isLoading.value,
                onTap: controller.signup,
              ),
            ),
            SizedBox(height: 20.h),

            SignupFooter(),
          ],
        ),
      ),
    );
  }
}
