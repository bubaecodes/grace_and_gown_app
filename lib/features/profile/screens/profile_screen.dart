import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/controllers/profile_controller.dart';
import 'package:grace_and_gown_app/features/profile/widgets/profile_header_card.dart';
import 'package:grace_and_gown_app/features/profile/widgets/profile_logout_button.dart';
import 'package:grace_and_gown_app/features/profile/widgets/profile_menu_section.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Prata',
                  fontSize: 24.sp,
                  letterSpacing: 1.sp,
                  color: AppColors.heading(context),
                ),
              ),
              SizedBox(height: 16.h),
              const ProfileHeaderCard(),
              SizedBox(height: 22.h),
              const _ProfileMenu(),
              SizedBox(height: 22.h),
              const ProfileLogoutButton(),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// The three menu groups. Each row raises a coming-soon toast for now —
/// swap the callback for real navigation as sub-screens get built.
class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu();

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileMenuSection(
          title: 'ACCOUNT',
          items: [
            ProfileMenuItem(
              icon: Icons.person_outline_rounded,
              label: 'My Details',
              onTap: () => controller.showComingSoon('My Details'),
            ),
            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              label: 'Addresses',
              onTap: () => controller.showComingSoon('Addresses'),
            ),
            ProfileMenuItem(
              icon: Icons.credit_card_outlined,
              label: 'Payment Methods',
              onTap: () => controller.showComingSoon('Payment Methods'),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        ProfileMenuSection(
          title: 'SUPPORT',
          items: [
            ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              label: 'Help Center',
              onTap: () => controller.showComingSoon('Help Center'),
            ),
            ProfileMenuItem(
              icon: Icons.mail_outline_rounded,
              label: 'Contact Us',
              onTap: () => controller.showComingSoon('Contact Us'),
            ),
            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              label: 'About',
              onTap: () => controller.showComingSoon('About'),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        ProfileMenuSection(
          title: 'SETTINGS',
          items: [
            ProfileMenuItem(
              icon: Icons.notifications_none_rounded,
              label: 'Notifications',
              onTap: () => controller.showComingSoon('Notifications'),
            ),
            ProfileMenuItem(
              icon: Icons.lock_outline_rounded,
              label: 'Privacy & Security',
              onTap: () => controller.showComingSoon('Privacy & Security'),
            ),
          ],
        ),
      ],
    );
  }
}
