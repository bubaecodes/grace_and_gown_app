import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/dashboard_placeholder.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPlaceholder(
      title: 'Bookings',
      icon: Icons.calendar_month_outlined,
      message: 'Your rentals and their dates will appear here.',
    );
  }
}