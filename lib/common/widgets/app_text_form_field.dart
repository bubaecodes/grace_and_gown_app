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
    this.controller,
    this.keyboardType,
    this.validator,
    this.textInputAction,
  });

  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final VoidCallback? iconToggle;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.strong(context),
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: AppColors.secondary(context),
          fontWeight: FontWeight.w500,
        ),
        // The prefix is decoration only (lock, mail, phone, ...). It used to
        // carry the visibility toggle, which made the eye icon dead and the
        // lock steal the tap — the toggle lives on the suffix below.
        prefixIcon: Icon(
          prefixIcon,
          size: 20.sp,
          color: AppColors.accent(context),
        ),
        // The suffix is the interactive icon (password eye). Callers may pass
        // either `onTap` or `iconToggle`; both mean "toggle this icon".
        suffixIcon: suffixIcon == null
            ? null
            : InkWell(
                onTap: onTap ?? iconToggle,
                child: Icon(
                  suffixIcon,
                  size: 20.sp,
                  color: AppColors.accent(context),
                ),
              ),
        filled: true,
        fillColor: AppColors.fieldFill(context),

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
            color: AppColors.accent(context),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            width: 1.7.sp,
            color: AppColors.accent(context),
          ),
        ),
      ),
    );
  }
}
