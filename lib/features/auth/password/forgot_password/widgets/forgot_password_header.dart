import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/auth_brand_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthBrandHeader(),
        SizedBox(height: 16.h),
        Text(
          AppTexts.forgotPasswordHeader,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Prata',
            fontSize: 28.sp,
            letterSpacing: 1.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.heading(context),
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Text(
            AppTexts.forgotPasswordSubHeader,
            textAlign: TextAlign.center,
            style: (Theme.of(context).textTheme.bodyMedium ??
                const TextStyle())
                .copyWith(
              color: AppColors.secondary(context),
              fontSize: 15.4.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}