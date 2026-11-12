import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Shared empty-state body for the tabs you'll build next.
class DashboardPlaceholder extends StatelessWidget {
  const DashboardPlaceholder({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76.sp,
              height: 76.sp,
              decoration: BoxDecoration(
                color: AppColors.fieldFill(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 34.sp, color: AppColors.accent(context)),
            ),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 24.sp,
                letterSpacing: 1.sp,
                color: AppColors.heading(context),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}