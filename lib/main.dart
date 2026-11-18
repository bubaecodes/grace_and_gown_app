import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_and_gown_app/app_initializer.dart';
import 'package:grace_and_gown_app/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage must finish before the first frame: the splash reads the
  // onboarding/session flags from it, and the wishlist loads its saved
  // ids from the same store. Skipping this leaves AppStorage uninitialised,
  // so every read falls back to its default and every write is dropped.
  await AppInitializer.init();

  SystemChrome.setSystemUIOverlayStyle(
    systemUiOverlayStyle(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

/// The app root — the full wrapper stack (toast/overlay/screenutil/route
/// table) lives in [MainApp].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MainApp();
}
