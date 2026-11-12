import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/home/widgets/category_row.dart';
import 'package:grace_and_gown_app/features/home/widgets/home_header.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/features/home/widgets/promo_carousel.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(),
              SizedBox(height: 16),
              PromoCarousel(),
              SizedBox(height: 20),
              CategoryRow(),
              SizedBox(height: 20),
              ProductGrid(),
            ],
          ),
        ),
      ),
    );
  }
}