import 'package:get/get.dart';
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

  void addToCart() => CustomSnackBar.showSafe(
    title: 'Added to Cart',
    message: '${product.name} was added to your cart.',
    type: ToastificationType.success,
  );

  void bookNow() => CustomSnackBar.showSafe(
    title: 'Booking Started',
    message: 'We\'re reserving ${product.name} for you.',
    type: ToastificationType.info,
  );
}