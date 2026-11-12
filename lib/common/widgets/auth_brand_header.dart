import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showBackButton)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.accent(context),
                size: 20.sp,
              ),
            ),
          ),
        Image.asset(
          AppImages.appLogo3,
          width: 80.w,
          fit: BoxFit.contain,
        ),
        Text(
          'GOWN & GRACE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Prata',
            fontSize: 22.sp,
            letterSpacing: 1.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.heading(context),
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 0.34,
                  color: AppColors.darkSageGreen,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.oliveGreen,
                  size: 24.w,
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 0.34,
                  color: AppColors.darkSageGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}