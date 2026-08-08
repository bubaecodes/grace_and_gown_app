import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:toastification/toastification.dart';

import 'app_initializer.dart';
import 'features/authentication/screens/splash/splash_screen.dart';
import 'utils/routes/app_pages.dart';
import 'utils/routes/routes.dart';
import 'utils/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: OverlaySupport.global(
        child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: _getDesignSize(),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return GetMaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              initialRoute: Routes.splashScreen,
              getPages: AppPages.pages,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }

  Size _getDesignSize() {
    final data = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    );

    return data.size.shortestSide >= 600
        ? const Size(834, 1194)
        : const Size(440, 976);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
}