import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

/// One launchable contact row: icon, title, subtitle and target link.
class _ContactRow {
  const _ContactRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.link,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  /// The URI to open, parsed on tap (mailto:, tel:, https:).
  final String link;
}

/// Real ways to reach the boutique, plus studio hours.
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const _rows = <_ContactRow>[
    _ContactRow(
      icon: Icons.mail_outline_rounded,
      title: 'Email',
      subtitle: 'hello@graceandgown.com',
      link: 'mailto:hello@graceandgown.com',
    ),
    _ContactRow(
      icon: Icons.phone_outlined,
      title: 'Phone',
      subtitle: '+234 801 234 5678',
      link: 'tel:+2348012345678',
    ),
    _ContactRow(
      icon: Icons.chat_outlined,
      title: 'WhatsApp',
      subtitle: '+234 901 234 5678',
      link: 'https://wa.me/2349012345678',
    ),
    _ContactRow(
      icon: Icons.location_on_outlined,
      title: 'Grace & Gown Studio',
      subtitle: '14 Admiralty Way, Lekki Phase 1, Lagos',
      link: 'https://maps.google.com/?q=Lekki+Phase+1',
    ),
  ];

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
              const _Header(title: 'Contact Us'),
              SizedBox(height: 6.h),
              Text(
                'We usually reply within a business day.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.elevatedSurface(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.accent(context).withValues(alpha: 0.35),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    for (var i = 0; i < _rows.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          thickness: 0.8,
                          color: AppColors.accent(context)
                              .withValues(alpha: 0.18),
                        ),
                      _ContactTile(row: _rows[i]),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                'STUDIO HOURS',
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
                  children: [
                    _HoursRow(
                      day: 'Monday – Saturday',
                      hours: '9:00am – 6:00pm',
                    ),
                    SizedBox(height: 10.h),
                    _HoursRow(day: 'Sunday', hours: 'Closed'),
                  ],
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
      message: 'We couldn\'t open that on this device — please try another '
          'way to reach us.',
      type: ToastificationType.error,
    );
  }
}

/// Icon circle + title/subtitle + chevron; taps launch the row's link.
class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.row});

  final _ContactRow row;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchLink(row.link),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        child: Row(
          children: [
            Container(
              width: 34.sp,
              height: 34.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.fieldFill(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                row.icon,
                size: 17.sp,
                color: AppColors.accent(context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.strong(context),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    row.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: AppColors.secondary(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// One "day → hours" line in the studio-hours card.
class _HoursRow extends StatelessWidget {
  const _HoursRow({required this.day, required this.hours});

  final String day;
  final String hours;

  @override
  Widget build(BuildContext context) {
    // The day label flexes so the pair can never overflow the card — at
    // larger system font scales both strings together exceed the row, and
    // two unbounded Texts just run off the edge.
    return Row(
      children: [
        Expanded(
          child: Text(
            day,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary(context),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          hours,
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
