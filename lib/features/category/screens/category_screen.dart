import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/features/category/controllers/category_controller.dart';
import 'package:grace_and_gown_app/features/category/data/gown_categories.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// The Category tab — a card for each entry in `GownCategory.all`, showing a
/// cover photo, the category name and how many pieces it holds. Tapping a card
/// opens the nested product list for that category (the same screen the
/// home-screen chips open).
class GownsScreen extends StatelessWidget {
  const GownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No-op once the dashboard has already put it — safe to call here so the
    // tab also works when pumped on its own.
    Get.put(CategoryController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop by Category',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Pick a category to see every piece in it.',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                final controller = CategoryController.instance;

                // Loading / error / data switch — retry restarts `reload()`.
                return AppLoadSwitch(
                  state: controller.state.value,
                  onRetry: controller.reload,
                  data: (context) => const _CategoryGrid(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// Two-up grid, matching the ProductGrid gutter (12) so both screens feel
/// like the same layout system.
class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 0.74,
      children: [
        // Same staggered zoom-in as the product grids, capped at index 8
        // (400ms) — the category list is short, so every card still feels
        // like it arrives in sequence.
        for (var i = 0; i < GownCategory.all.length; i++)
          AppEntrance(
            delay: Duration(milliseconds: 50 * (i > 8 ? 8 : i)),
            child: _CategoryCard(category: GownCategory.all[i]),
          ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final GownCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(Routes.categoryProductsScreen, arguments: category),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.accent(context).withValues(alpha: 0.35),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(category.cover, fit: BoxFit.cover),
            // Bottom-up scrim keeps the title readable over any photo.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.35, 1],
                  colors: [Colors.transparent, Color(0xCC000000)],
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              right: 10.w,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(category.icon, size: 16.sp, color: AppColors.white),
              ),
            ),
            Positioned(
              left: 12.w,
              right: 12.w,
              bottom: 12.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 15.sp,
                      letterSpacing: 0.5.sp,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${category.count} pieces',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white.withValues(alpha: 0.8),
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
