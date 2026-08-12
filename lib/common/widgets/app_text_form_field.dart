import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class AppFormTextField extends StatelessWidget {
  const AppFormTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.iconToggle,
    this.obscureText = false,
  });

  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final VoidCallback? iconToggle;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.primaryGreen,
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: InkWell(
          onTap: iconToggle,
          child: Icon(
            prefixIcon,
            size: 20.sp,
            color: AppColors.primaryGreen,
          ),
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(suffixIcon, size: 20.sp, color: AppColors.primaryGreen,),
        ),
        filled: true,
        fillColor: AppColors.sageGreen.withValues(alpha: 0.34),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            width: 0.7.sp,
            color: AppColors.primaryGreen,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            width: 1.7.sp,
            color: AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }
}
