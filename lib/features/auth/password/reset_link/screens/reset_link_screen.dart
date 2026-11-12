import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/auth_brand_header.dart';
import 'package:grace_and_gown_app/features/auth/password/reset_link/widgets/reset_link_form.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class ResetLinkScreen extends StatelessWidget {
  const ResetLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: Column(
          children: [
            const AuthBrandHeader(),
            SizedBox(height: 20.h),
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: AppColors.sageGreen.withValues(alpha: 0.34),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mark_email_read_rounded,
                color: AppColors.primaryGreen,
                size: 48.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppTexts.passwordResetLinkHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 28.sp,
                letterSpacing: 1.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGreen,
              ),
            ),
            SizedBox(height: 10.h),
            const ResetLinkForm(),
          ],
        ),
      ),
    );
  }
}