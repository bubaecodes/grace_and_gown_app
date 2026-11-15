import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Bottom sheet for picking a fitting day and time.
///
/// Opens with cleared selections (via [BookingsController.openSheet]) so a
/// previous pick never carries over. Confirm is inert until both are chosen.
Future<void> showBookingSheet(BuildContext context) {
  BookingsController.instance.openSheet();

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.elevatedSurface(context),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
    ),
    builder: (_) => const _BookingSheet(),
  );
}

class _BookingSheet extends StatelessWidget {
  const _BookingSheet();

  @override
  Widget build(BuildContext context) {
    final controller = BookingsController.instance;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 16.h),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.secondary(context).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                controller.upcoming.value == null
                    ? 'Book a Fitting'
                    : 'Reschedule Fitting',
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 18.sp,
                  letterSpacing: 0.6.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 14.h),

              // --- Day ---
              Text(
                'SELECT A DAY',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8.sp,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 76.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.availableDays.length,
                  separatorBuilder: (_, _) => SizedBox(width: 8.w),
                  itemBuilder: (_, index) {
                    final day = controller.availableDays[index];

                    // Compare on the calendar day, not the instant —
                    // availableDays is midnight-based, picks may not be.
                    final isPicked = controller.selectedDate.value != null &&
                        day.year == controller.selectedDate.value!.year &&
                        day.month == controller.selectedDate.value!.month &&
                        day.day == controller.selectedDate.value!.day;

                    return _DayChip(
                      key: ValueKey('booking-day-$index'),
                      day: day,
                      selected: isPicked,
                      onTap: () => controller.pickDate(day),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // --- Time ---
              Text(
                'SELECT A TIME',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8.sp,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final time in BookingsController.availableTimes)
                    _TimeChip(
                      time: time,
                      selected: controller.selectedTime.value == time,
                      onTap: () => controller.pickTime(time),
                    ),
                ],
              ),
              SizedBox(height: 20.h),

              SizedBox(height: 6.h),
              Text(
                'A ${BookingsController.bookingFee} booking fee secures your '
                'slot. You\'ll pay it on the next step.',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 14.h),

              // --- Continue to payment ---
              InkWell(
                onTap: controller.canConfirm
                    ? () {
                        // Pops the sheet, then pushes the payment screen
                        // from the bookings tab underneath it.
                        Navigator.of(context).pop();
                        controller.continueToPayment();
                      }
                    : null,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 52.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: controller.canConfirm
                        ? AppColors.sageGreen
                        : AppColors.fieldFill(context),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.accent(context)),
                  ),
                  child: Center(
                    child: Text(
                      controller.canConfirm
                          ? 'Continue to Payment · ${BookingsController.bookingFee}'
                          : 'Pick a Day and Time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: controller.canConfirm
                            ? AppColors.white
                            : AppColors.secondary(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    super.key,
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final DateTime day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 54.w,
        padding: EdgeInsets.symmetric(vertical: 9.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.sageGreen.withValues(alpha: 0.30)
              : AppColors.fieldFill(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected
                ? AppColors.sageGreen
                : AppColors.accent(context).withValues(alpha: 0.30),
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              weekdays[day.weekday - 1],
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary(context),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${day.day}',
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 16.sp,
                color: selected
                    ? AppColors.heading(context)
                    : AppColors.strong(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.time,
    required this.selected,
    required this.onTap,
  });

  final String time;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.sageGreen.withValues(alpha: 0.30)
              : AppColors.fieldFill(context),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: selected
                ? AppColors.sageGreen
                : AppColors.accent(context).withValues(alpha: 0.30),
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            color: selected
                ? AppColors.heading(context)
                : AppColors.strong(context),
          ),
        ),
      ),
    );
  }
}
