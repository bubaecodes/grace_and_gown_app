import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/profile/controllers/payment_methods_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

/// Saved payment methods: card rows with default/delete actions and an
/// add-card bottom sheet. Only the last four digits are ever stored.
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodsController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(title: 'Payment Methods'),
              SizedBox(height: 6.h),
              Text(
                'Cards saved for the booking fee and rentals.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                final list = controller.cards;

                if (list.isEmpty) {
                  return const _EmptyCards();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < list.length; i++)
                      _CardRow(card: list[i], index: i),
                  ],
                );
              }),
              SizedBox(height: 8.h),
              _PrimaryAction(
                label: 'Add Card',
                onTap: () => _showAddSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Add-card sheet, styled like the booking sheet: elevated surface,
  /// rounded top and a drag handle.
  void _showAddSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.elevatedSurface(context),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      // Let the keyboard push the fields up instead of covering them.
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const _AddCardSheet(),
      ),
    );
  }
}

/// One saved card: brand + masked number + expiry/holder, then actions.
class _CardRow extends StatelessWidget {
  const _CardRow({required this.card, required this.index});

  final PaymentCardEntry card;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = PaymentMethodsController.instance;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
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
                width: 40.sp,
                height: 40.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.fieldFill(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.credit_card_rounded,
                  size: 20.sp,
                  color: AppColors.accent(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          card.brand,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3.sp,
                            color: AppColors.strong(context),
                          ),
                        ),
                        if (card.isDefault) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.sageGreen,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '•••• ${card.last4}',
                      style: TextStyle(
                        fontFamily: 'Prata',
                        fontSize: 16.sp,
                        letterSpacing: 1.sp,
                        color: AppColors.strong(context),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${card.expiry}  ·  ${card.holder}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (!card.isDefault)
                InkWell(
                  onTap: () => controller.setDefault(index),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                    child: Text(
                      'Set as default',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.link(context),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () => controller.removeAt(index),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shown when every card has been deleted.
class _EmptyCards extends StatelessWidget {
  const _EmptyCards();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
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
            width: 64.sp,
            height: 64.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.credit_card_outlined,
              size: 30.sp,
              color: AppColors.accent(context),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No saved cards yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 18.sp,
              letterSpacing: 0.5.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add a card to settle the booking fee faster next time.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
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

/// Bottom sheet form for adding a card. The number must be 16 digits;
/// only the last four are kept, and the brand is inferred from the first.
class _AddCardSheet extends StatefulWidget {
  const _AddCardSheet();

  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _formKey = GlobalKey<FormState>();

  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _holder = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _holder.dispose();
    super.dispose();
  }

  /// Closes the sheet and stores the card (last four digits only) when
  /// every field validates.
  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final digits = _number.text.replaceAll(RegExp(r'\D'), '');
    final last4 = digits.substring(digits.length - 4);

    PaymentMethodsController.instance.addCard(
      number: _number.text,
      expiry: _expiry.text.trim(),
      holder: _holder.text.trim(),
    );

    CustomSnackBar.showSafe(
      title: 'Card Added',
      message: 'Your card ending in $last4 has been saved.',
      type: ToastificationType.success,
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color:
                          AppColors.secondary(context).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Add Card',
                  style: TextStyle(
                    fontFamily: 'Prata',
                    fontSize: 18.sp,
                    letterSpacing: 0.6.sp,
                    color: AppColors.heading(context),
                  ),
                ),
                SizedBox(height: 14.h),
                _fieldLabel(context, 'Card number'),
                AppFormTextField(
                  controller: _number,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: '16 digits',
                  prefixIcon: Icons.credit_card_rounded,
                  validator: (value) {
                    final digits =
                        (value ?? '').replaceAll(RegExp(r'\D'), '');
                    if (digits.isEmpty) return 'Enter your card number';
                    if (digits.length != 16) {
                      return 'Card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                _fieldLabel(context, 'Expiry'),
                AppFormTextField(
                  controller: _expiry,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  hintText: 'MM/YY',
                  prefixIcon: Icons.calendar_today_outlined,
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
                SizedBox(height: 12.h),
                _fieldLabel(context, 'Holder name'),
                AppFormTextField(
                  controller: _holder,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  hintText: 'Name on card',
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Holder name is required.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                Text(
                  'Demo card store — only the last four digits are kept.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary(context),
                  ),
                ),
                SizedBox(height: 16.h),
                _PrimaryAction(label: 'Save Card', onTap: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Field label styled like the auth forms (see login_form.dart).
Widget _fieldLabel(BuildContext context, String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      label,
      style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
          .copyWith(
        color: AppColors.secondary(context),
        fontSize: 15.4.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

/// Back arrow + screen title, matching the other Profile sub-screens.
class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
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
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4.sp,
              color: AppColors.heading(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// The full-width sage primary button.
class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
