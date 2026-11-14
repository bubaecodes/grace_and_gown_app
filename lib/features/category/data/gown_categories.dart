import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';

/// One browsable category of the shop.
///
/// Single source of truth for both entry points into a category: the icon chips
/// on the home screen and the cards on the Category tab. Filtering is a plain
/// `Product.category` match, so [label] must stay in sync with the values
/// written in `SampleProducts`.
class GownCategory {
  const GownCategory({
    required this.label,
    required this.title,
    required this.icon,
    required this.cover,
  });

  /// Matches `Product.category` — the key used to filter the catalogue.
  final String label;

  /// Display name for cards and screen titles ("White" → "White Gowns").
  final String title;

  /// Same icon the home-screen chip uses, so both entry points look related.
  final IconData icon;

  /// Representative photo for the category card. Always a curated jpg —
  /// `gown_1..27` are ~2.3MB PNGs and would be far too heavy for a card.
  final String cover;

  /// Every product in this category, in catalogue order.
  List<Product> get products =>
      SampleProducts.all.where((p) => p.category == label).toList();

  /// Number of pieces in this category, without holding the list.
  int get count =>
      SampleProducts.all.where((p) => p.category == label).length;

  /// Ordered to match the home-screen chip row.
  static const List<GownCategory> all = [
    GownCategory(
      label: 'White',
      title: 'White Gowns',
      icon: Icons.diamond_outlined,
      cover: 'assets/images/category/gown_28.jpg',
    ),
    GownCategory(
      label: 'Court',
      title: 'Court Gowns',
      icon: Icons.account_balance_outlined,
      cover: 'assets/images/category/gown_34.jpg',
    ),
    GownCategory(
      label: 'Trad',
      title: 'Trad Gowns',
      icon: Icons.emoji_people_outlined,
      cover: 'assets/images/category/gown_31.jpg',
    ),
    GownCategory(
      label: 'Accessories',
      title: 'Accessories',
      icon: Icons.watch_outlined,
      cover: 'assets/images/category/gown_39.jpg',
    ),
    GownCategory(
      label: 'Reception',
      title: 'Reception Gowns',
      icon: Icons.celebration_outlined,
      cover: 'assets/images/category/gown_32.jpg',
    ),
  ];

  /// Lookup for callers that only carry a [label] (e.g. saved product data).
  static GownCategory byLabel(String label) =>
      all.firstWhere((c) => c.label == label);
}
