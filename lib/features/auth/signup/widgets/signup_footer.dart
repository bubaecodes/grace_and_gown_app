import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Already have an account? ',
          style: (Theme.of(context).textTheme.bodySmall ?? const TextStyle())
              .copyWith(
            color: AppColors.sageGreen,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: 'Login',
              style: (Theme.of(context).textTheme.bodySmall ?? const TextStyle())
                  .copyWith(
                color: AppColors.accentText(context),
                fontSize: 15.3.sp,
                fontWeight: FontWeight.w500,
              ),
              // Replace instead of push: toggling signup ↔ login must not
              // stack a new route each time.
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.offNamed(Routes.loginScreen),
            ),
          ]
        ),
      ),
    );
  }
}
