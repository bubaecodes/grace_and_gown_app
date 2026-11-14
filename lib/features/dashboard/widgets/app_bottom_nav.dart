import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.badgeCount = 0,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final int badgeCount;
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _NavItem(
      label: 'Category',
      icon: Icons.checkroom_outlined,
      activeIcon: Icons.checkroom_rounded,
    ),
    /// Bump badgeCount once you have a real cart.
    _NavItem(
      label: 'Cart',
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag_rounded,
    ),
    _NavItem(
      label: 'Bookings',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month_rounded,
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        border: Border(
          top: BorderSide(
            color: AppColors.accent(context).withValues(alpha: 0.35),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              selected ? item.activeIcon : item.icon,
                              size: 23.sp,
                              color: color,
                            ),
                            if (item.badgeCount > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  width: 8.sp,
                                  height: 8.sp,
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w500,
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