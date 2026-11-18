import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/controllers/security_settings_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// The four short policy sections on the Privacy half of the screen.
const _privacySections = <({String heading, String body})>[
  (
    heading: 'What we collect',
    body: 'We collect the details you give us when you create an account — '
        'your name, email, phone number and the addresses you save for '
        'delivery and pickup. Booking records (slot and fee receipt) stay '
        'tied to your account so we can put a face to every fitting. Card '
        'payments are handled by our payment processor; we only ever keep '
        'the last four digits and the brand. We also store light device '
        'preferences, like your theme, so the app feels the same on every '
        'visit.',
  ),
  (
    heading: 'How we use it',
    body: 'Your details let us confirm bookings, prepare gowns for your '
        'fitting and reach you when plans change. Saved addresses drive '
        'delivery and pickup for rentals, and booking records keep our '
        'accounts straight. With your permission we send style updates and '
        'new-arrival alerts — you can switch these off any time under '
        'Security below. We never sell your data or build advertising '
        'profiles for other companies.',
  ),
  (
    heading: 'Sharing',
    body: 'We share only what the service needs: our payment processor sees '
        'your card details at checkout, and a Lagos-area courier sees the '
        'name, phone and address for the one delivery they are making. '
        'Stylists and fitters access your measurements when you visit the '
        'studio. We do not sell your personal information, and we never '
        'share it for third-party advertising. If that ever changes, we will '
        'ask you first.',
  ),
  (
    heading: 'Your rights',
    body: 'You can review or edit your name, email and phone from My '
        'Details, and manage saved addresses and cards from the Profile tab. '
        'You can ask us for a copy of everything we hold, or ask us to '
        'delete your account and its data, by writing to '
        'hello@graceandgown.com. We action verified requests within 30 '
        'days, except where tax or legal rules require us to keep certain '
        'records. Every marketing email also carries an unsubscribe link.',
  ),
];

/// The privacy policy summary plus the security toggles.
class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecuritySettingsController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(title: 'Privacy & Security'),
              SizedBox(height: 18.h),
              _sectionLabel(context, 'PRIVACY'),
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
                    for (var i = 0; i < _privacySections.length; i++) ...[
                      if (i > 0) SizedBox(height: 14.h),
                      Text(
                        _privacySections[i].heading,
                        style: TextStyle(
                          fontFamily: 'Prata',
                          fontSize: 14.sp,
                          letterSpacing: 0.3.sp,
                          color: AppColors.strong(context),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        _privacySections[i].body,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              _sectionLabel(context, 'SECURITY'),
              SizedBox(height: 8.h),
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
                    _SwitchRow(
                      title: 'Biometric lock',
                      subtitle:
                          'Require fingerprint or face unlock when the app '
                              'reopens.',
                      value: controller.biometricLock,
                      onChanged: (value) =>
                          controller.biometricLock.value = value,
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.8,
                      color:
                          AppColors.accent(context).withValues(alpha: 0.18),
                    ),
                    _SwitchRow(
                      title: 'Marketing emails',
                      subtitle: 'New arrivals, style notes and seasonal '
                          'offers.',
                      value: controller.marketingEmails,
                      onChanged: (value) =>
                          controller.marketingEmails.value = value,
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.8,
                      color:
                          AppColors.accent(context).withValues(alpha: 0.18),
                    ),
                    _SwitchRow(
                      title: 'Order updates',
                      subtitle: 'Booking confirmations, delivery and pickup '
                          'alerts.',
                      value: controller.orderUpdates,
                      onChanged: (value) =>
                          controller.orderUpdates.value = value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Uppercase section label above each card (see ACCOUNT / SUPPORT).
  Widget _sectionLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8.sp,
          color: AppColors.secondary(context),
        ),
      ),
    );
  }
}

/// One themed toggle row — title/subtitle on the left, live switch on the
/// right (its own Obx, so flipping only rebuilds the switch).
class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final RxBool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.strong(context),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Obx(
            () => Switch(
              value: value.value,
              onChanged: onChanged,
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.sageGreen,
              inactiveThumbColor: AppColors.secondary(context),
              inactiveTrackColor: AppColors.fieldFill(context),
            ),
          ),
        ],
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
