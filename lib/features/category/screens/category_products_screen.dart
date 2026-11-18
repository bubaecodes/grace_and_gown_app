import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/features/category/data/gown_categories.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

/// Everything in a single category — pushed from a card on the Category tab or
/// from a chip on the home screen, and popped by the back arrow.
///
/// Stateful because this screen owns its load cycle: the category arrives via
/// `Get.arguments` and the products are "fetched" on mount. API integration
/// replaces the [_load] body with a real request (set [LoadState.error] in
/// the catch); nothing else changes.
class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late final GownCategory _category;
  LoadState _state = LoadState.loading;

  @override
  void initState() {
    super.initState();
    _category = Get.arguments as GownCategory? ?? GownCategory.all.first;
    _load();
  }

  Future<void> _load() async {
    setState(() => _state = LoadState.loading);
    try {
      await Future<void>.microtask(() {});
      if (!mounted) return;
      setState(() => _state = LoadState.data);
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = LoadState.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _category.products;

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 4.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Back arrow and the gown type share one row — the leading
              /// icon reads as attached to its title.
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      _category.title,
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
                ],
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
              // Loading / error / data switch — retry restarts `_load()`.
              AppLoadSwitch(
                state: _state,
                onRetry: _load,
                data: (context) {
                  if (products.isEmpty) {
                    return _EmptyCategory(category: _category);
                  }
                  return ProductGrid(products: products);
                },
              ),
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
