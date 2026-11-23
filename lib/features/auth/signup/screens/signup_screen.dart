import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';
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
        // The keyboard shrinks the viewport; let the column scroll instead
        // of overflowing when a field is focused.
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 4.h),
          child: Column(
            children: [
              // Two-beat entrance: brand header first, then the headline
              // pair and form together a beat later.
              const AppEntrance(child: SignupHeader()),
              AppEntrance(
                delay: const Duration(milliseconds: 80),
                child: Text(
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
              ),
              SizedBox(height: 2.h),
              AppEntrance(
                delay: const Duration(milliseconds: 80),
                child: Text(
                  'Sign up to get started',
                  textAlign: TextAlign.center,
                  style:
                      (Theme.of(context).textTheme.bodyMedium ??
                              const TextStyle())
                          .copyWith(
                            color: AppColors.secondary(context),
                            fontSize: 15.4.sp,
                            fontWeight: FontWeight.w500,
                          ),
                ),
              ),
              const AppEntrance(
                delay: Duration(milliseconds: 80),
                child: SignupForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
