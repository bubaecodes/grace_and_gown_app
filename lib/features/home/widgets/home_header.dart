import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Find Your Perfect Gown',
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 24.sp,
              letterSpacing: 0.6.sp,
              height: 1.25,
              color: AppColors.heading(context),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        IconButton(
          onPressed: () => CustomSnackBar.showSafe(
            title: 'Notifications',
            message: 'You have no new notifications yet.',
            type: ToastificationType.info,
          ),
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                size: 26.sp,
                color: AppColors.accent(context),
              ),
              Positioned(
                right: 3.w,
                top: 4.h,
                child: Container(
                  width: 8.sp,
                  height: 8.sp,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}