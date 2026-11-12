import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/auth/signup/widgets/signup_form.dart';
import 'package:grace_and_gown_app/features/auth/signup/widgets/signup_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 4.h,),
          child: Column(
            children: [
              SignupHeader(),
              Text(
                'Create Your Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 28.sp,
                  letterSpacing: 1.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Sign up to get started',
                textAlign: TextAlign.center,
                style: (Theme.of(context).textTheme.bodyMedium ??
                    const TextStyle())
                    .copyWith(
                  color: AppColors.secondary(context),
                  fontSize: 15.4.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}