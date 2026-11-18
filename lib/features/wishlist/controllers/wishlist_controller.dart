import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

/// Shared wishlist state for the session.
///
/// Stores product **ids** rather than instances so toggling from the card,
/// the product-details heart or the wishlist itself always agrees. The list
/// resolves against [SampleProducts.all] (the single catalogue), keeping
/// favourites in catalogue order no matter where they were added.
///
/// Registered by [DashboardScreen] — popping a pushed route (details,
/// category) won't dispose it; logging out of the dashboard will, which
/// gives each session a fresh wishlist.
class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  /// Ids of the products the user has hearted.
  final RxSet<String> favoriteIds = <String>{}.obs;

  /// Where the list is in its load cycle. Starts [LoadState.loading] and
  /// settles on [LoadState.data] once `reload()` finishes.
  final Rx<LoadState> state = LoadState.loading.obs;

  /// (Re)loads the saved list.
  ///
  /// A [Future.microtask] for now — it exists so the screen already switches
  /// on [state]. API integration replaces the body with a real fetch of the
  /// user's saved ids: `await` it, flip to [LoadState.data], and set
  /// [LoadState.error] in the catch.
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

  /// Whether [id] is favourited. Reactive: safe to call inside `Obx`.
  bool isFavorite(String id) => favoriteIds.contains(id);

  /// Add the product if it isn't saved, remove it if it is.
  void toggle(Product product) {
    if (!favoriteIds.remove(product.id)) {
      favoriteIds.add(product.id);
    }
  }

  /// The saved products, in catalogue order.
  List<Product> get favorites => [
        for (final product in SampleProducts.all)
          if (favoriteIds.contains(product.id)) product,
      ];
}
