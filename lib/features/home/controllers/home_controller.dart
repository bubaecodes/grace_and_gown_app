import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

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

  /// Where the grid is in its load cycle. Starts [LoadState.loading] and
  /// settles on [LoadState.data] once `reload()` finishes.
  final Rx<LoadState> state = LoadState.loading.obs;

  /// (Re)loads the grid's data.
  ///
  /// Currently a [Future.microtask] that flips straight to [LoadState.data]
  /// — it exists so the screens already switch on [state]. API integration
  /// replaces the body with a real fetch: `await` it, then `state.value =
  /// LoadState.data`, and set [LoadState.error] in the catch.
  Future<void> reload() async {
    state.value = LoadState.loading;
    try {
      await Future<void>.microtask(() {});
      if (isClosed) return;
      state.value = LoadState.data;
    } catch (_) {
      if (isClosed) return;
      state.value = LoadState.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
    reload();
  }

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
