import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/controllers/notifications_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Recent account activity — booking confirmations, payment receipts and
/// studio updates. Reached from Profile → Notifications and from the bell
/// on the home header.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              SizedBox(height: 16.h),
              Obx(() {
                final controller = NotificationsController.instance;

                if (controller.items.isEmpty) return const _EmptyState();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < controller.items.length; i++) ...[
                      _NotificationTile(
                        notification: controller.items[i],
                        onTap: () => controller.markRead(i),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// Back arrow + title, with the list actions trailing it — "Mark all read"
/// only while something is unread, "Clear" only while there's anything to
/// clear. Matching the other Profile sub-screens' header.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = NotificationsController.instance;

      return Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: AppColors.strong(context),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Notifications',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4.sp,
                color: AppColors.heading(context),
              ),
            ),
          ),
          if (controller.unreadCount > 0) ...[
            _HeaderAction(label: 'Mark all read', onTap: controller.markAllRead),
          ],
          if (controller.items.isNotEmpty) ...[
            SizedBox(width: 12.w),
            _HeaderAction(label: 'Clear', onTap: controller.clear),
          ],
        ],
      );
    });
  }
}

/// A compact text button in the header row.
class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.link(context),
          ),
        ),
      ),
    );
  }
}

/// One notification row — tapping it marks just that entry as read, which
/// drops its accent dot. Unread entries also get the stronger border.
class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final read = notification.read;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.elevatedSurface(context),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.accent(context)
                .withValues(alpha: read ? 0.16 : 0.45),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.sp,
              height: 40.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.sageGreen.withValues(
                  alpha: AppColors.isDark(context) ? 0.18 : 0.30,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification.icon,
                size: 19.sp,
                color: AppColors.accent(context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.strong(context),
                          ),
                        ),
                      ),
                      if (!read) ...[
                        SizedBox(width: 6.w),
                        Container(
                          width: 8.sp,
                          height: 8.sp,
                          decoration: BoxDecoration(
                            color: AppColors.accent(context),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notification.time,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown once every notification has been cleared.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64.sp,
            height: 64.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 30.sp,
              color: AppColors.accent(context),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'You\'re all caught up',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 18.sp,
              letterSpacing: 0.5.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Booking confirmations, payment receipts and studio updates '
                'will show up here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
