import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/features/home/controllers/home_controller.dart';
import 'package:grace_and_gown_app/features/home/widgets/category_row.dart';
import 'package:grace_and_gown_app/features/home/widgets/home_header.dart';
import 'package:grace_and_gown_app/features/home/widgets/home_search_bar.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/features/home/widgets/promo_carousel.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Entrance cascade: each block waits 60ms longer than the
              // last, so Home "arrives" top-to-bottom when it opens. The
              // grid below keeps its own per-card stagger instead of a
              // base delay, so the whole sequence still finishes quickly.
              const AppEntrance(child: HomeHeader()),
              SizedBox(height: 14.h),
              const AppEntrance(
                delay: Duration(milliseconds: 60),
                child: HomeSearchBar(),
              ),
              SizedBox(height: 16.h),
              const AppEntrance(
                delay: Duration(milliseconds: 120),
                child: PromoCarousel(),
              ),
              SizedBox(height: 20.h),
              const AppEntrance(
                delay: Duration(milliseconds: 180),
                child: CategoryRow(),
              ),
              SizedBox(height: 20.h),
              const _HomeGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The grid, reactive to the [HomeController] search query and sort.
///
/// Empty-query + featured-sort returns `SampleProducts.items` unchanged, so the
/// default home screen still renders exactly as it did before search existed.
class _HomeGrid extends StatelessWidget {
  const _HomeGrid();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final home = HomeController.instance;
      // Read inside the Obx, not in the data closure below: GetX only
      // tracks reads that happen while this builder runs, and the closure
      // executes later during AppLoadSwitch's own build — untracked reads
      // there mean query/sort changes would never rebuild the grid.
      final products = home.visibleProducts;

      // Loading / error / data switch — the retry restarts `reload()`.
      return AppLoadSwitch(
        state: home.state.value,
        onRetry: home.reload,
        data: (context) {
          if (products.isEmpty) {
            return _NoResults(query: home.query.value);
          }
          return ProductGrid(products: products);
        },
      );
    });
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    // The parent Column is start-aligned, so this needs its own full-width
    // [Center] — otherwise the block hugs the left edge.
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 40.sp,
              color: AppColors.secondary(context),
            ),
            SizedBox(height: 14.h),
            Text(
              'No gowns match "${query.trim()}".',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.strong(context),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Try another name, or clear the search to see everything.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
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
