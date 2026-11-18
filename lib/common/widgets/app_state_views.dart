import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

/// Centered spinner shown while a screen's data is on its way.
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.label});

  /// Optional caption under the spinner.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.accent(context),
              ),
            ),
            if (label != null) ...[
              SizedBox(height: 14.h),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Failure state with a retry button — [onRetry] restarts the load.
class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, this.message, required this.onRetry});

  /// What went wrong, in the user's words. Falls back to a generic line.
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                Icons.cloud_off_rounded,
                size: 30.sp,
                color: AppColors.accent(context),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
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
              message ?? 'We couldn\'t load this just now. Check your '
                  'connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary(context),
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: onRetry,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.sageGreen,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.accent(context)),
                ),
                child: Text(
                  'Try again',
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Friendly "nothing here" block, matching the app's existing empty states
/// (circle icon → Prata title → supporting line).
class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    this.icon = Icons.inbox_rounded,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.sp,
              height: 64.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.fieldFill(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30.sp, color: AppColors.accent(context)),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 18.sp,
                letterSpacing: 0.5.sp,
                color: AppColors.strong(context),
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Switches between the three [LoadState] branches in one place, so every
/// screen wires loading/error/data identically:
///
/// ```dart
/// AppLoadSwitch(
///   state: controller.state.value,
///   onRetry: controller.reload,
///   data: (context) => ProductGrid(products: controller.items),
/// )
/// ```
class AppLoadSwitch extends StatelessWidget {
  const AppLoadSwitch({
    super.key,
    required this.state,
    required this.onRetry,
    required this.data,
    this.loading = const AppLoadingView(),
    this.errorMessage,
  });

  final LoadState state;
  final VoidCallback onRetry;

  /// The screen's real content, built once data has landed.
  final WidgetBuilder data;

  /// Shown while [LoadState.loading]; swap for a skeleton later if wanted.
  final Widget loading;

  /// Overrides the error view's fallback message.
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      LoadState.loading => loading,
      LoadState.error => AppErrorView(message: errorMessage, onRetry: onRetry),
      LoadState.data => data(context),
    };
  }
}
