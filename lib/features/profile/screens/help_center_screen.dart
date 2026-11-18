import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// The six FAQ entries — a question, then the boutique's answer.
const _faqs = <({String question, String answer})>[
  (
    question: 'How do fittings work?',
    answer: 'Book a slot from the Bookings tab and pay the ₦20,000 booking '
        'fee to secure it. Arrive a few minutes early — a stylist takes your '
        'measurements, pulls gowns in your size and walks you through any '
        'alterations. Most fittings wrap up in under an hour.',
  ),
  (
    question: 'What is the ₦20,000 booking fee?',
    answer: 'It\'s a hold charge that reserves your fitting slot and covers '
        'preparing your rail ahead of the visit. The fee comes off your final '
        'rental or purchase total, so nothing is lost when you fall in love '
        'with a gown.',
  ),
  (
    question: 'Can I reschedule my fitting?',
    answer: 'Yes. Open the booking in your Bookings tab at least 24 hours '
        'before your slot and pick a new day or time — your first reschedule '
        'is free. Closer than that, message us and we\'ll do what we can.',
  ),
  (
    question: 'What is your cancellation policy?',
    answer: 'Cancel more than 48 hours before your slot and the booking fee '
        'is refunded in full. Inside 48 hours the fee is kept, since the slot '
        'and gowns were held for you alone.',
  ),
  (
    question: 'How do delivery and pickup work?',
    answer: 'We deliver within Lagos for a flat fee and pick rentals up the '
        'day after your event. Outside Lagos we ship both ways at cost — tell '
        'us at checkout and we\'ll send a quote the same day.',
  ),
  (
    question: 'Which payment methods do you accept?',
    answer: 'Cards, bank transfers and USSD all work. Rentals are paid in '
        'full before pickup, while the booking fee can be settled right here '
        'in the app.',
  ),
];

/// FAQ list for common questions, with a shortcut to Contact Support.
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(title: 'Help Center'),
              SizedBox(height: 6.h),
              Text(
                'Fittings, fees and policies — tap a question to expand.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),
              // Material rather than a decorated Container: ExpansionTile's
              // internal ListTile paints its ink on the nearest Material
              // ancestor, and a decorated Container in between hides the
              // splash (Flutter flags it with an assertion).
              Material(
                color: AppColors.elevatedSurface(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: BorderSide(
                    color: AppColors.accent(context).withValues(alpha: 0.35),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    for (var i = 0; i < _faqs.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          thickness: 0.8,
                          color: AppColors.accent(context)
                              .withValues(alpha: 0.18),
                        ),
                      _FaqTile(faq: _faqs[i]),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              _PrimaryAction(
                label: 'Contact Support',
                onTap: () => Get.toNamed(Routes.contactUsScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One expandable question-and-answer pair.
class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.faq});

  final ({String question, String answer}) faq;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColors.accent(context),
      collapsedIconColor: AppColors.accent(context),
      textColor: AppColors.strong(context),
      collapsedTextColor: AppColors.strong(context),
      tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
      childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
      title: Text(
        faq.question,
        style: TextStyle(
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.strong(context),
        ),
      ),
      children: [
        Text(
          faq.answer,
          style: TextStyle(
            fontSize: 12.5.sp,
            height: 1.6,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary(context),
          ),
        ),
      ],
    );
  }
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
