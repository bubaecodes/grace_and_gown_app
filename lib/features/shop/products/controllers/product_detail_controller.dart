import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:grace_and_gown_app/features/dashboard/data/sample_products.dart';
import 'package:grace_and_gown_app/features/shop/products/models/products.dart';
import 'package:grace_and_gown_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class ProductDetailController extends GetxController {
  static ProductDetailController get instance => Get.find();

  late final Product product;

  @override
  void onInit() {
    product = Get.arguments as Product? ?? SampleProducts.items.first;
    super.onInit();
  }

  /// Reads straight from the shared wishlist, so this heart, the card
  /// hearts and the Wishlist tab always agree. Safe inside `Obx`.
  bool get isFavourite => WishlistController.instance.isFavorite(product.id);

  void toggleFavourite() => WishlistController.instance.toggle(product);

  /// Saves the product to the shared wishlist — an explicit *add*, so it
  /// never un-hearts a piece that was already saved — then confirms with a
  /// toast and lands the user on the Bookings tab.
  void addToWishlist() {
    if (!isFavourite) WishlistController.instance.toggle(product);
    CustomSnackBar.showSafe(
      title: 'Added to Wishlist',
      message: '${product.name} was saved to your wishlist.',
      type: ToastificationType.success,
    );
    goToBookings();
  }

  void bookNow() {
    CustomSnackBar.showSafe(
      title: 'Booking Started',
      message: 'We\'re reserving ${product.name} for you.',
      type: ToastificationType.info,
    );
    goToBookings();
  }

  /// Pops every pushed route (details, category list) back to the dashboard
  /// and selects the Bookings tab, so both action buttons land in one place.
  void goToBookings() {
    DashboardController.instance
        .goToTab(DashboardController.bookingsTabIndex);
    Get.until((route) => route.isFirst);
  }
}