import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// The favorited gowns, listed as a fitting checklist.
///
/// These are the pieces to pull off the rail first when the client walks
/// in, so the list reads top-to-bottom in the order they were saved.
/// Tapping a row opens its product page; the heart removes it here — the
/// same shared wishlist state the cards and the Wishlist tab use.
class TryOnList extends StatelessWidget {
  const TryOnList({super.key});

  @override
  Widget build(BuildContext context) {
    // Registered here too so the tab works when pumped on its own.
    Get.put(WishlistController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRY-ON LIST',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8.sp,
            color: AppColors.secondary(context),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your saved gowns — we\'ll have these ready first when you arrive.',
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary(context),
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() {
          final items = BookingsController.instance.tryOnList;

          if (items.isEmpty) return const _EmptyTryOnList();

          return Container(
            decoration: BoxDecoration(
              color: AppColors.elevatedSurface(context),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.accent(context).withValues(alpha: 0.35),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 0.8,
                      color: AppColors.accent(context).withValues(alpha: 0.18),
                    ),
                  _TryOnRow(product: items[i]),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _TryOnRow extends StatelessWidget {
  const _TryOnRow({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistController.instance;

    return InkWell(
      onTap: () => Get.toNamed(
        Routes.productDetailScreen,
        arguments: product,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 54.w,
                height: 68.h,
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 15.sp,
                      letterSpacing: 0.3.sp,
                      color: AppColors.strong(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${product.category}  ·  ${product.price}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Its own handler, so removing from the list doesn't also
            // open the product page.
            InkWell(
              onTap: () => wishlist.toggle(product),
              customBorder: const CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.favorite_rounded,
                  size: 19.sp,
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown until the user hearts their first gown.
class _EmptyTryOnList extends StatelessWidget {
  const _EmptyTryOnList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.favorite_outline_rounded,
            size: 26.sp,
            color: AppColors.accent(context),
          ),
          SizedBox(height: 10.h),
          Text(
            'Nothing saved yet',
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 15.sp,
              letterSpacing: 0.4.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Heart a gown anywhere in the app and it joins this list.',
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
    );
  }
}
