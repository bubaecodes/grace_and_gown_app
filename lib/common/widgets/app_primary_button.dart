import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 65.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.sageGreen,
          border: Border.all(color: AppColors.accent(context)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            width: 24.sp,
            height: 24.sp,
            child: const CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 2.4,
            ),
          )
              : Text(
            text,
            style: (Theme.of(context).textTheme.headlineLarge ??
                const TextStyle()).copyWith(
              color: AppColors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}