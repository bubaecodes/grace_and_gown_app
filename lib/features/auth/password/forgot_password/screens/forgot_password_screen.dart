import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/widgets/forgot_password_form.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/widgets/forgot_password_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        // The keyboard shrinks the viewport; let the column scroll instead
        // of overflowing when a field is focused.
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Two-beat entrance: header first, then the form a beat later.
              const AppEntrance(child: ForgotPasswordHeader()),
              SizedBox(height: 10.h),
              const AppEntrance(
                delay: Duration(milliseconds: 80),
                child: ForgotPasswordForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
