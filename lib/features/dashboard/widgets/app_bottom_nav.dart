import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

/// Floating pill bottom bar.
///
/// Instead of a full-width strip glued to the bottom edge, the bar sits on a
/// rounded card with a soft shadow and margin on every side, so the scaffold
/// background shows around it. The active tab gets an animated tinted pill
/// behind its icon + label; icons are Iconsax for a lighter, more polished
/// look than the stock Material outlines.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      icon: Iconsax.home_1,
    ),
    _NavItem(
      label: 'Category',
      icon: Iconsax.category,
    ),
    _NavItem(
      label: 'Wishlist',
      icon: Iconsax.heart,
    ),
    _NavItem(
      label: 'Bookings',
      icon: Iconsax.calendar,
    ),
    _NavItem(
      label: 'Profile',
      icon: Iconsax.user,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    // SafeArea first so the pill (and its shadow) clears the home-indicator
    // inset; the margin then floats it off the screen edges.
    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.elevatedSurface(context),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(
            color: AppColors.accent(context).withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.14),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Obx(() {
          final current = controller.selectedIndex.value;

          return Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = i == current;
              final color = selected
                  ? AppColors.accentText(context)
                  : AppColors.secondary(context);

              return Expanded(
                child: InkWell(
                  onTap: () => controller.goToTab(i),
                  borderRadius: BorderRadius.circular(20.r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(
                      vertical: 7.h,
                      horizontal: 4.w,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.sageGreen.withValues(
                              alpha: AppColors.isDark(context) ? 0.18 : 0.30,
                            )
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item.icon, size: 23.sp, color: color),
                        SizedBox(height: 4.h),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
