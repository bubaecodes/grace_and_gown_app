import 'utils/storage/app_storage.dart';

class AppInitializer {
  static Future<void> init() async {
    // Local storage (session flags, wishlist, recent searches). Must finish
    // before runApp so the splash can read where to hand off to.
    await AppStorage.init();
  }
}
