import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';

/// Sort choices offered by the filter button beside the home search bar.
enum HomeSort { featured, priceAscending, priceDescending, name }

extension HomeSortLabel on HomeSort {
  String get label => switch (this) {
        HomeSort.featured => 'Featured',
        HomeSort.priceAscending => 'Price: low to high',
        HomeSort.priceDescending => 'Price: high to low',
        HomeSort.name => 'Name: A to Z',
      };
}

/// Search query + sort state behind the home grid.
///
/// Reads the curated [SampleProducts.items] list — the same list the grid used
/// before search existed, so with an empty query and [HomeSort.featured] the
/// home screen renders exactly as it always did.
class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  /// Live text in the search field.
  final RxString query = ''.obs;

  /// Active sort — [HomeSort.featured] keeps the curated order untouched.
  final Rx<HomeSort> sort = HomeSort.featured.obs;

  /// True when the sort chip on the filter button should be lit.
  bool get hasSort => sort.value != HomeSort.featured;

  /// What the home grid should render for the current [query] and [sort].
  List<Product> get visibleProducts {
    final needle = query.value.trim().toLowerCase();

    final filtered = SampleProducts.items.where((product) {
      if (needle.isEmpty) return true;
      return product.name.toLowerCase().contains(needle) ||
          product.category.toLowerCase().contains(needle);
    }).toList();

    final int Function(Product, Product)? compare = switch (sort.value) {
      HomeSort.priceAscending =>
        (a, b) => _priceOf(a).compareTo(_priceOf(b)),
      HomeSort.priceDescending =>
        (a, b) => _priceOf(b).compareTo(_priceOf(a)),
      HomeSort.name =>
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      HomeSort.featured => null,
    };

    if (compare != null) filtered.sort(compare);
    return filtered;
  }

  /// Numeric value of a price like `'₦150,000 / 3 days'` → `150000`.
  ///
  /// Matches only the first run of digits, so the `/ 3 days` part never leaks
  /// into the comparison.
  static int _priceOf(Product product) {
    final digits =
        RegExp(r'\d[\d,]*').stringMatch(product.price)?.replaceAll(',', '');
    return int.tryParse(digits ?? '') ?? 0;
  }
}
