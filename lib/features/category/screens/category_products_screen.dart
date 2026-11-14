import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/category/data/gown_categories.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Everything in a single category — pushed from a card on the Category tab or
/// from a chip on the home screen, and popped by the back arrow.
class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments as GownCategory? ?? GownCategory.all.first;
    final products = category.products;

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 4.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.accent(context),
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                category.title,
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 24.sp,
                  letterSpacing: 1.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '${products.length} pieces in this category.',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 20.h),
              if (products.isEmpty)
                _EmptyCategory(category: category)
              else
                ProductGrid(products: products),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCategory extends StatelessWidget {
  const _EmptyCategory({required this.category});

  final GownCategory category;

  @override
  Widget build(BuildContext context) {
    // Full-width [Center]: the screen's column is start-aligned.
    return Padding(
      padding: EdgeInsets.only(top: 48.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 42.sp,
              color: AppColors.secondary(context),
            ),
            SizedBox(height: 14.h),
            Text(
              'No pieces in ${category.title} yet — check back soon.',
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
      ),
    );
  }
}
