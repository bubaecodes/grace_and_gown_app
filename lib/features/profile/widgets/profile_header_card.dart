import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/controllers/profile_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// Avatar + name/email/phone card at the top of the Profile tab.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.instance;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          // Initials avatar — swap for a real photo once one exists.
          Container(
            width: 64.sp,
            height: 64.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent(context).withValues(alpha: 0.5),
              ),
            ),
            child: Obx(
              () => Text(
                controller.initials,
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 22.sp,
                  letterSpacing: 1.sp,
                  color: AppColors.accentText(context),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.name.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 19.sp,
                      letterSpacing: 0.4.sp,
                      color: AppColors.strong(context),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Obx(
                  () => Text(
                    controller.email.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Obx(
                  () => Text(
                    controller.phone.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: () => Get.toNamed(Routes.editProfileScreen),
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Text(
                'Edit',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.link(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
