import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/auth/password/confirm_password/widgets/confirm_password_form.dart';
import 'package:grace_and_gown_app/features/auth/password/confirm_password/widgets/confirm_password_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: Column(
          children: [
            ConfirmPasswordHeader(),
            SizedBox(height: 10.h),
            ConfirmPasswordForm(),
          ],
        ),
      ),
    );
  }
}