import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_card.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';

/// Two-column grid laid out as rows of two cards.
///
/// Replaces the old GridView + fixed `mainAxisExtent` because card heights now
/// follow each photo's aspect ratio. `IntrinsicHeight` + stretch makes both
/// cards in a row share one height, so row bottoms stay aligned.
class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, this.products = SampleProducts.items});

  /// Which products to show. Defaults to the curated home-screen list.
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    // Chunk the list into rows of 2 (last row may have 1 item).
    final rows = <List<int>>[];
    for (var i = 0; i < products.length; i += 2) {
      rows.add([i, if (i + 1 < products.length) i + 1]);
    }

    return Column(
      children: [
        for (var r = 0; r < rows.length; r++) ...[
          if (r > 0) SizedBox(height: 12.h),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var c = 0; c < rows[r].length; c++) ...[
                  if (c > 0) SizedBox(width: 12.w),
                  Expanded(child: ProductCard(product: products[rows[r][c]])),
                ],
                // Keep a lone card in the last row at half width.
                if (rows[r].length == 1) ...[
                  SizedBox(width: 12.w),
                  const Expanded(child: SizedBox()),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
