import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/widgets/forgot_password_form.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/widgets/forgot_password_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: Column(
          children: [
            ForgotPasswordHeader(),
            SizedBox(height: 10.h),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}