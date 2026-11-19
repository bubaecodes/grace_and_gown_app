import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/features/bookings/screens/bookings_screen.dart';
import 'package:grace_and_gown_app/features/category/screens/category_screen.dart';
import 'package:grace_and_gown_app/features/wishlist/screens/wishlist_screen.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/app_bottom_nav.dart';
import 'package:grace_and_gown_app/features/home/screens/home_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/profile_screen.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    // Registered at the session root so pushing/popping the details or
    // category routes never disposes the wishlist; logging out of the
    // dashboard clears it for the next session.
    Get.put(WishlistController());

    // The tabs themselves never unmount (IndexedStack keeps every tab's
    // state — scroll position, filters, form fields), so only this wrapper
    // re-animates when the selected tab changes.
    const tabs = [
      HomeScreen(),
      GownsScreen(),
      WishlistScreen(),
      BookingsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: Obx(() {
        final index = DashboardController.instance.selectedIndex.value;

        // Accessibility: with "remove animations" on, swap instantly.
        if (MediaQuery.disableAnimationsOf(context)) {
          return IndexedStack(index: index, children: tabs);
        }

        // Keyed on the index: each tab change creates a fresh animation
        // state, so the new tab fades in from 0.97 scale. The first build
        // animates too, which reads as the dashboard itself arriving.
        return TweenAnimationBuilder<double>(
          key: ValueKey(index),
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          builder: (context, t, child) => Opacity(
            opacity: t,
            child: Transform.scale(scale: 0.97 + 0.03 * t, child: child),
          ),
          child: IndexedStack(index: index, children: tabs),
        );
      }),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
