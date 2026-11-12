import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/text_strings.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class ResetCompleteSheet extends StatelessWidget {
  const ResetCompleteSheet({super.key});

  static Future<void> show() {
    return Get.bottomSheet(
      const ResetCompleteSheet(),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: AppColors.sageGreen.withValues(alpha: 0.34),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.success,
              size: 42.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            AppTexts.resetBottomModalHeader,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 24.sp,
              letterSpacing: 1.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppTexts.resetBottomModalSubHeader,
            textAlign: TextAlign.center,
            style: (Theme.of(context).textTheme.bodyMedium ??
                const TextStyle())
                .copyWith(
              color: AppColors.grey,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),
          AppPrimaryButton(
            text: AppTexts.resetBottomModalBtn,
            onTap: () => Get.offAllNamed(Routes.loginScreen),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}