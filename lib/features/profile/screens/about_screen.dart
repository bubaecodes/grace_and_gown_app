import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

/// The brand story shown on the About screen.
const _story = [
  'Grace & Gown is a Lagos bridal boutique built for women who want to '
      'shine on their big day without the wardrobe regret. We opened our '
      'first studio in Lekki Phase 1 with a rail of gowns, a fitting room '
      'and one simple idea: the perfect dress should fit your body and your '
      'budget.',
  'Today we lend hundreds of gowns for weddings, owambes and red-carpet '
      'events, and we also carry a small ready-to-wear line for the days '
      'that call for something quieter. Every piece is steamed, fitted and '
      'cared for by our in-house stylists before it reaches you.',
  'From your first booking to the final pickup, we keep things personal — '
      'real people, real fittings, and a studio that always has time for one '
      'more alteration.',
];

/// Brand story plus app/links info for Grace & Gown.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
              const _Header(title: 'About'),
              SizedBox(height: 16.h),
              for (final paragraph in _story)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    paragraph,
                    style: TextStyle(
                      fontSize: 13.sp,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              Text(
                'APP',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8.sp,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
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
                    _InfoRow(label: 'Version', value: '1.0.0'),
                    SizedBox(height: 12.h),
                    _InfoRow(label: 'Made in', value: 'Lagos, Nigeria'),
                    Divider(
                      height: 18,
                      thickness: 0.8,
                      color: AppColors.accent(context).withValues(alpha: 0.18),
                    ),
                    _LinkRow(
                      label: 'Website',
                      value: 'graceandgown.example.com',
                      link: 'https://graceandgown.example.com',
                    ),
                    SizedBox(height: 10.h),
                    _LinkRow(
                      label: 'Instagram',
                      value: 'instagram.com/graceandgown',
                      link: 'https://instagram.com/graceandgown',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              Center(
                child: Text(
                  'GRACE & GOWN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Prata',
                    fontSize: 17.sp,
                    letterSpacing: 1.2.sp,
                    color: AppColors.heading(context),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Center(
                child: Text(
                  'Lagos · Nigeria',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6.sp,
                    color: AppColors.secondary(context),
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

/// Opens [link] in the matching external app; failures surface as an
/// error toast instead of stranding the user on this screen.
Future<void> _launchLink(String link) async {
  try {
    final opened = await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) throw Exception('Could not open $link');
  } catch (_) {
    CustomSnackBar.showSafe(
      title: 'Opening Link',
      message: 'We couldn\'t open that on this device — please try again '
          'later.',
      type: ToastificationType.error,
    );
  }
}

/// A static label/value line (Version, Made in, ...).
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary(context),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.strong(context),
          ),
        ),
      ],
    );
  }
}

/// A tappable label → link row that opens the URL in the browser.
class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.label,
    required this.value,
    required this.link,
  });

  final String label;
  final String value;
  final String link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchLink(link),
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary(context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.link(context),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.sp,
              color: AppColors.secondary(context),
            ),
          ],
        ),
      ),
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
