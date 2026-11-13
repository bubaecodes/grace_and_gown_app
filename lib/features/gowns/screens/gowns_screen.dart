import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Browse the whole catalogue — every image in `assets/images/gowns` as a
/// product, using the same card grid as the home screen. Cards open the
/// product detail screen.
class GownsScreen extends StatelessWidget {
  const GownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = SampleProducts.all.length;

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Collection',
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 24.sp,
                  letterSpacing: 1.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Browse all $count pieces in the collection.',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 20.h),
              ProductGrid(products: SampleProducts.all),
            ],
          ),
        ),
      ),
    );
  }
}
