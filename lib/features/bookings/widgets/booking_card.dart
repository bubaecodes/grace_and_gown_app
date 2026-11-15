import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/features/bookings/models/booking.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// The card for the visit that's on the books — or the empty state when
/// nothing is scheduled.
///
/// Reschedule reopens the booking sheet; Cancel asks first, the same way
/// the Profile logout does.
class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookingsController.instance;

    // The read happens inside this closure, so GetX registers the
    // dependency and rebuilds the card whenever the visit changes.
    return Obx(() {
      final booking = controller.upcoming.value;

      if (booking == null) return const _NoBookingCard();

      return _BookedCard(booking: booking, controller: controller);
    });
  }
}

class _BookedCard extends StatelessWidget {
  const _BookedCard({required this.booking, required this.controller});

  final Booking booking;
  final BookingsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  booking.status,
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5.sp,
                    color: AppColors.success,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // Only unpaid visits would ever appear without it, since a
              // booking is created by a successful payment — but a real
              // backend could hand us a pending one, so the badge is
              // conditional.
              if (booking.isPaid) ...[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.accent(context).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 11.sp,
                        color: AppColors.accent(context),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'PAID',
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5.sp,
                          color: AppColors.accent(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  booking.reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6.sp,
                    color: AppColors.secondary(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            booking.style,
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 19.sp,
              letterSpacing: 0.4.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 12.h),
          _DetailRow(
            icon: Icons.calendar_today_outlined,
            text: BookingsController.formatDay(booking.date),
          ),
          SizedBox(height: 8.h),
          _DetailRow(
            icon: Icons.schedule_rounded,
            text: '${booking.time}  ·  90 min fitting',
          ),
          SizedBox(height: 8.h),
          _DetailRow(
            icon: Icons.location_on_outlined,
            text: 'Grace & Gown Studio, Lekki Phase 1',
          ),
          if (booking.isPaid && booking.paymentReference != null) ...[
            SizedBox(height: 8.h),
            _DetailRow(
              icon: Icons.receipt_long_outlined,
              text: '${BookingsController.bookingFee} paid · '
                  '${booking.paymentReference}',
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _CardAction(
                  label: 'Reschedule',
                  color: AppColors.link(context),
                  onTap: controller.openSheet,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _CardAction(
                  label: 'Cancel',
                  color: AppColors.error,
                  onTap: () => _confirmCancel(context, controller),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    BookingsController controller,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.elevatedSurface(dialogContext),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Cancel Booking',
          style: TextStyle(
            fontFamily: 'Prata',
            fontSize: 19.sp,
            color: AppColors.strong(dialogContext),
          ),
        ),
        content: Text(
          'Are you sure you want to cancel this fitting?',
          style: TextStyle(
            fontSize: 13.5.sp,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary(dialogContext),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Keep It',
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary(dialogContext),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Cancel Booking',
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) controller.cancelBooking();
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15.sp, color: AppColors.accent(context)),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// Shown when no visit is scheduled — points at the booking button below.
class _NoBookingCard extends StatelessWidget {
  const _NoBookingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 58.sp,
            height: 58.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_available_outlined,
              size: 27.sp,
              color: AppColors.accent(context),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'No booking yet',
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 17.sp,
              letterSpacing: 0.5.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Pick a day and time below to reserve your fitting.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5.sp,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
