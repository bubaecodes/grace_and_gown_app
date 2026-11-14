import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/bookings_screen.dart';
import 'package:grace_and_gown_app/features/category/screens/category_screen.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/profile_screen.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/wishlist_screen.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/app_bottom_nav.dart';
import 'package:grace_and_gown_app/features/home/screens/home_screen.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

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