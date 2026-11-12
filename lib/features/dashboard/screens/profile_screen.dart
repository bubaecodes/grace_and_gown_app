import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/dashboard_placeholder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPlaceholder(
      title: 'Profile',
      icon: Icons.person_outline_rounded,
      message: 'Your details, addresses and settings will live here.',
    );
  }
}