import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/dashboard_placeholder.dart';

class GownsScreen extends StatelessWidget {
  const GownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPlaceholder(
      title: 'Gowns',
      icon: Icons.checkroom_outlined,
      message: 'Every gown in the collection will be browsable here.',
    );
  }
}