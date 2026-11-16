import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/features/bookings/widgets/booking_card.dart';
import 'package:grace_and_gown_app/features/bookings/widgets/booking_sheet.dart';
import 'package:grace_and_gown_app/features/bookings/widgets/try_on_list.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// The Bookings tab: the visit that's on the books, a button to book or
/// reschedule one, and the try-on list of favorited gowns to have ready
/// first when the client arrives.
class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bookings',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Your fittings at the studio.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),

              // Rebuilds when a booking is made, rescheduled or cancelled.
              // The Obx lives inside BookingCard, which reads `upcoming`
              // directly in its own closure — GetX only tracks observables
              // read there, not in child widgets it builds.
              const BookingCard(),
              SizedBox(height: 14.h),

              InkWell(
                onTap: () => showBookingSheet(context),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 52.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.sageGreen,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.accent(context)),
                  ),
                  child: Center(
                    child: Text(
                      'Book a Fitting',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              const TryOnList(),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
