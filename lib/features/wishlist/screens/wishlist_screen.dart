import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// The Wishlist tab — every gown the user has hearted, resolved live from
/// [WishlistController]. Hearty a card (or the details-screen heart) anywhere
/// in the app and it shows up here; un-heart it and it disappears.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Registered here too so the tab works even when pumped on its own
    // (it's a no-op once DashboardScreen has already put it).
    Get.put(WishlistController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wishlist',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Gowns you\'ve saved for later.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                final wishlist = WishlistController.instance;
                // Read inside the Obx, not in the data closure below: GetX
                // only tracks reads made while this builder runs, and the
                // closure executes later during AppLoadSwitch's own build —
                // untracked there, hearting a gown would never rebuild.
                final favorites = wishlist.favorites;

                // Loading / error / data switch — retry restarts `reload()`.
                return AppLoadSwitch(
                  state: wishlist.state.value,
                  onRetry: wishlist.reload,
                  data: (context) {
                    if (favorites.isEmpty) {
                      return _EmptyWishlist(context: context);
                    }
                    return ProductGrid(products: favorites);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shown until the user hearts their first gown.
class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist({required this.context});

  final BuildContext context;

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
              Icons.favorite_outline_rounded,
              size: 30.sp,
              color: AppColors.accent(context),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No favorites yet',
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
            'Tap the heart on any gown to save it here.',
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
