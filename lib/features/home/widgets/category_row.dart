import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class _Category {
  const _Category(this.label, this.icon);

  final String label;
  final IconData icon;
}

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  static const List<_Category> _categories = [
    _Category('White', Icons.diamond_outlined),
    _Category('Court', Icons.account_balance_outlined),
    _Category('Trad', Icons.emoji_people_outlined),
    _Category('Accessories', Icons.watch_outlined),
    _Category('Reception', Icons.celebration_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    /// Labels are white (as requested), so each chip needs a dark backing —
    /// white text on the light scaffold would be invisible.
    final chipBg =
    AppColors.isDark(context) ? AppColors.darkCard : AppColors.darkGreen;

    return Row(
      children: [
        for (var i = 0; i < _categories.length; i++) ...[
          if (i > 0) SizedBox(width: 8.w),
          Expanded(
            child: _CategoryChip(
              category: _categories[i],
              //background: chipBg,
              background: AppColors.sageGreen,
            ),
          ),
        ],
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category, required this.background});

  final _Category category;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomSnackBar.showSafe(
        title: category.label,
        message: '${category.label} filtering is coming next.',
        type: ToastificationType.info,
      ),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.accent(context).withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          children: [
            Icon(
              category.icon,
              size: 24.sp,
              color: AppColors.white,
            ),
            SizedBox(height: 8.h),
            Text(
              category.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}