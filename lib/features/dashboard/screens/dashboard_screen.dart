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

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: Obx(() => IndexedStack(
        index: DashboardController.instance.selectedIndex.value,
        children: const [
          HomeScreen(),
          GownsScreen(),
          WishlistScreen(),
          BookingsScreen(),
          ProfileScreen(),
        ],
      )),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}