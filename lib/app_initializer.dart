// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// import 'firebase_options.dart';
import 'utils/storage/app_storage.dart';

class AppInitializer {
  static Future<void> init() async {
    // Initialize Firebase
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    // Local storage (session flags, wishlist, recent searches). Must finish
    // before runApp so the splash can read where to hand off to.
    await AppStorage.init();

    // // Initialize local storage if your app uses it
    // await Get.putAsync(
    //       () => LocalStorageService().init(),
    //   permanent: true,
    // );
  }
}
