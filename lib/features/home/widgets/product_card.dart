import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onSelected});

  final Product product;

  /// Called just before navigating to the details screen — the Search screen
  /// uses it to file the query in the recent searches when a result is
  /// tapped. Optional: everywhere else it stays null.
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelected?.call();
        Get.toNamed(Routes.productDetailScreen, arguments: product);
      },
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.elevatedSurface(context),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.accent(context).withValues(alpha: 0.35),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'product-${product.id}',
                  child: SizedBox(
                    width: double.infinity,
                    height: 155.h,
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
                // Above the card's own InkWell, so it carries its own
                // tap handler — without it, tapping the heart would open
                // the product details instead of saving the gown.
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: _FavoriteButton(product: product),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.heading(context),
                      ),
                    ),
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary(context),
                      ),
                    ),
                    Text(
                      product.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.heading(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Heart toggle in the corner of a product card.
///
/// A translucent circular backdrop keeps it readable over any photo, and
/// `Obx` rebuilds it whenever this product's saved state changes — from
/// the card, the details screen or the wishlist.
class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.put(WishlistController());

    return Obx(() {
      final saved = wishlist.isFavorite(product.id);

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => wishlist.toggle(product),
          customBorder: const CircleBorder(),
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppColors.elevatedSurface(context).withValues(alpha: 0.85),
              shape: BoxShape.circle,
            ),
            child: _PulseIcon(saved: saved),
          ),
        ),
      );
    });
  }
}

/// The heart icon with a gentle pop whenever the saved state flips.
///
/// Keyed on [saved], so toggling creates a fresh animation: a sine curve
/// runs 0→1, swelling the icon to 1.2× at the midpoint and settling it
/// back to rest — a pulse, not a bounce. Untouched state changes (other
/// products hearting, list rebuilds) keep the same key and don't re-run it.
class _PulseIcon extends StatelessWidget {
  const _PulseIcon({required this.saved});

  final bool saved;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      saved ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
      size: 17.sp,
      color: saved ? AppColors.error : AppColors.accent(context),
    );

    // Accessibility: no pulse when the system disables animations.
    if (MediaQuery.disableAnimationsOf(context)) return icon;

    return TweenAnimationBuilder<double>(
      key: ValueKey(saved),
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Transform.scale(
        // sin(π·t) is 0 at both ends and 1 at the midpoint: rest → 1.2× → rest.
        scale: 1 + 0.2 * math.sin(math.pi * t),
        child: child,
      ),
      child: icon,
    );
  }
}
