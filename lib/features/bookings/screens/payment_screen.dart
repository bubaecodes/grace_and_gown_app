import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/bookings_controller.dart';
import 'package:grace_and_gown_app/features/bookings/controllers/payment_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Checkout for the ₦20,000 booking fee.
///
/// The client picks how they want to pay, settles, and only then does the
/// booking come into existence — see [BookingsController.finalizeBooking].
/// Everything is simulated; a real gateway replaces [PaymentController.pay].
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Registered by `continueToPayment` before this route is pushed, so
    // this picks up the same instance — it only creates one when the
    // screen is opened directly (e.g. in a test).
    final controller = Get.put(PaymentController());
    final bookings = BookingsController.instance;

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: Obx(() {
          if (controller.isPaid.value) {
            return _SuccessView(controller: controller);
          }

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(controller: controller),
                SizedBox(height: 16.h),
                _AmountCard(bookings: bookings),
                SizedBox(height: 20.h),
                _MethodPicker(controller: controller),
                SizedBox(height: 20.h),
                _MethodDetails(controller: controller, bookings: bookings),
                SizedBox(height: 24.h),
                _PayButton(controller: controller),
                SizedBox(height: 10.h),
                Center(
                  child: TextButton(
                    onPressed: controller.cancel,
                    child: Text(
                      'Cancel and go back',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: controller.cancel,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: AppColors.strong(context),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'Checkout',
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4.sp,
            color: AppColors.heading(context),
          ),
        ),
      ],
    );
  }
}

/// The amount due, plus the slot it secures.
class _AmountCard extends StatelessWidget {
  const _AmountCard({required this.bookings});

  final BookingsController bookings;

  @override
  Widget build(BuildContext context) {
    // Its own Obx: this value is read here, not in the parent's closure —
    // GetX only rebuilds what read the value inside its own builder.
    return Obx(() {
      final day = bookings.selectedDate.value;
      final time = bookings.selectedTime.value;

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
            Text(
              'BOOKING FEE',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8.sp,
                color: AppColors.secondary(context),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              BookingsController.bookingFee,
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 30.sp,
                letterSpacing: 0.5.sp,
                color: AppColors.strong(context),
              ),
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 1,
              thickness: 0.8,
              color: AppColors.accent(context).withValues(alpha: 0.2),
            ),
            SizedBox(height: 10.h),
            if (day != null && time != null)
              Text(
                'Secures your fitting · ${BookingsController.formatDay(day)} '
                'at $time',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              )
            else
              Text(
                'Pick a day and time on the previous step to continue.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _MethodPicker extends StatelessWidget {
  const _MethodPicker({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    const labels = {
      PaymentMethod.card: ('Card', Icons.credit_card_rounded),
      PaymentMethod.bankTransfer: ('Bank Transfer', Icons.account_balance_outlined),
      PaymentMethod.ussd: ('USSD', Icons.dialpad_rounded),
    };

    // `method` is read here, so this widget owns the rebuild.
    return Obx(() {
      final selected = controller.method.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAY WITH',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8.sp,
              color: AppColors.secondary(context),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              for (final entry in labels.entries) ...[
                Expanded(
                  child: _MethodTile(
                    label: entry.value.$1,
                    icon: entry.value.$2,
                    selected: selected == entry.key,
                    onTap: () => controller.select(entry.key),
                  ),
                ),
                if (entry.key != labels.keys.last) SizedBox(width: 8.w),
              ],
            ],
          ),
        ],
      );
    });
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 74.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.sageGreen.withValues(alpha: 0.26)
              : AppColors.fieldFill(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected
                ? AppColors.sageGreen
                : AppColors.accent(context).withValues(alpha: 0.3),
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: selected
                  ? AppColors.heading(context)
                  : AppColors.accent(context),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                color: selected
                    ? AppColors.heading(context)
                    : AppColors.secondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The inputs for whichever method is selected.
class _MethodDetails extends StatelessWidget {
  const _MethodDetails({required this.controller, required this.bookings});

  final PaymentController controller;
  final BookingsController bookings;

  @override
  Widget build(BuildContext context) {
    // The switch reads `method`, so the rebuild has to happen here.
    return Obx(() {
      switch (controller.method.value) {
        case PaymentMethod.card:
          return _CardForm(controller: controller);
        case PaymentMethod.bankTransfer:
          return _TransferDetails(controller: controller);
        case PaymentMethod.ussd:
          return _UssdDetails(controller: controller);
      }
    });
  }
}

class _CardForm extends StatelessWidget {
  const _CardForm({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormTextField(
            hintText: 'Card number',
            prefixIcon: Icons.credit_card_rounded,
            controller: controller.cardNumber,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
              if (digits.isEmpty) return 'Enter your card number';
              if (digits.length != 16) return 'Card number must be 16 digits';
              return null;
            },
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: AppFormTextField(
                  hintText: 'MM/YY',
                  prefixIcon: Icons.calendar_today_outlined,
                  controller: controller.cardExpiry,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final text = (value ?? '').trim();
                    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(text)) {
                      return 'Use MM/YY';
                    }
                    final month = int.parse(text.substring(0, 2));
                    if (month < 1 || month > 12) return 'Bad month';
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppFormTextField(
                  hintText: 'CVV',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: controller.cardCvv,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
                    if (digits.length != 3) return '3 digits';
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          AppFormTextField(
            hintText: 'Name on card',
            prefixIcon: Icons.person_outline_rounded,
            controller: controller.cardName,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if ((value ?? '').trim().length < 3) return 'Enter the name on your card';
              return null;
            },
          ),
          SizedBox(height: 10.h),
          Text(
            'Demo checkout — no card is charged. Any 16 digits will do.',
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferDetails extends StatelessWidget {
  const _TransferDetails({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.accent(context).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer ${BookingsController.bookingFee} to:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 12.h),
          _DetailLine(label: 'Bank', value: 'Grace & Gown MFB'),
          _DetailLine(label: 'Account', value: '0123456789'),
          _DetailLine(label: 'Name', value: 'GRACE AND GOWN STUDIOS'),
          SizedBox(height: 6.h),
          Text(
            'Use your booking reference as the transfer narration, then tap '
            'Pay below once it\'s sent.',
            style: TextStyle(
              fontSize: 11.5.sp,
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

class _UssdDetails extends StatelessWidget {
  const _UssdDetails({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.accent(context).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dial this code from your phone:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '*737*000*20000#',
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 20.sp,
                letterSpacing: 1.sp,
                color: AppColors.strong(context),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Confirm with your PIN, then tap Pay below to complete the '
            'booking.',
            style: TextStyle(
              fontSize: 11.5.sp,
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

class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 78.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary(context),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.strong(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  const _PayButton({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    // `isProcessing` is read here — its own Obx, or the spinner never
    // appears (the parent closure doesn't see this read).
    return Obx(() {
      final processing = controller.isProcessing.value;

      return InkWell(
        onTap: processing
            ? null
            : () {
                // Card details have to be valid before anything is charged;
                // the other two methods carry no form.
                if (controller.method.value == PaymentMethod.card &&
                    !controller.validateCard()) {
                  return;
                }
                controller.pay();
              },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 54.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: processing
                ? AppColors.sageGreen.withValues(alpha: 0.6)
                : AppColors.sageGreen,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.accent(context)),
          ),
          child: Center(
            child: processing
                ? SizedBox(
                    width: 22.sp,
                    height: 22.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'Pay ${BookingsController.bookingFee}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}

/// Shown once the fee settled and the booking exists.
class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76.sp,
              height: 76.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 38.sp,
                color: AppColors.success,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Payment Successful',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: 23.sp,
                letterSpacing: 0.8.sp,
                color: AppColors.strong(context),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '${BookingsController.bookingFee} received — your fitting is '
              'confirmed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5.sp,
                height: 1.6,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary(context),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.elevatedSurface(context),
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: AppColors.accent(context).withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                'Ref ${controller.paymentReference.value ?? '—'}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6.sp,
                  color: AppColors.secondary(context),
                ),
              ),
            ),
            SizedBox(height: 34.h),
            InkWell(
              onTap: controller.done,
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
                    'Back to Bookings',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
