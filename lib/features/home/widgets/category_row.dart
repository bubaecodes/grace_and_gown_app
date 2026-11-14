import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/category/data/gown_categories.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// Home-screen chip row. Same five categories as the Category tab — tapping a
/// chip opens that category's nested product list instead of a toast.
class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = GownCategory.all;

    return Row(
      children: [
        for (var i = 0; i < categories.length; i++) ...[
          if (i > 0) SizedBox(width: 8.w),
          Expanded(child: _CategoryChip(category: categories[i])),
        ],
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final GownCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.categoryProductsScreen,
        arguments: category,
      ),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.sageGreen,
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
