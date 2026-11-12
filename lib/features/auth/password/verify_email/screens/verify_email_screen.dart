import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/auth_brand_header.dart';
import 'package:grace_and_gown_app/features/auth/password/verify_email/widgets/verify_email_form.dart';
import 'package:grace_and_gown_app/features/auth/password/verify_email/widgets/verify_email_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: Column(
          children: [
            const AuthBrandHeader(),
            SizedBox(height: 16.h),
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: AppColors.sageGreen.withValues(alpha: 0.34),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.alternate_email_rounded,
                color: AppColors.primaryGreen,
                size: 48.sp,
              ),
            ),
            SizedBox(height: 16.h),
            const VerifyEmailHeader(),
            SizedBox(height: 14.h),
            const VerifyEmailForm(),
          ],
        ),
      ),
    );
  }
}