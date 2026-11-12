import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/dashboard/widgets/dashboard_placeholder.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPlaceholder(
      title: 'Wishlist',
      icon: Icons.favorite_outline_rounded,
      message: 'Items you save will show up here.',
    );
  }
}