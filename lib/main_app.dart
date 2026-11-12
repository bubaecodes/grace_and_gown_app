import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:toastification/toastification.dart';

import 'app_initializer.dart';
import 'features/auth/splash/screens/splash_screen.dart';
import 'utils/routes/app_pages.dart';
import 'utils/routes/routes.dart';
import 'utils/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// System bar colors for the current [brightness] so the status bar icons and
/// the navigation bar always contrast with the active light/dark theme.
SystemUiOverlayStyle systemUiOverlayStyle(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: isDark ? AppColors.dark : Colors.white,
    systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  SystemChrome.setSystemUIOverlayStyle(
    systemUiOverlayStyle(WidgetsBinding.instance.platformDispatcher.platformBrightness),
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
              initialRoute: Routes.splashScreen,
              getPages: AppPages.pages,
              /// Follow the device light/dark setting.
              //themeMode: ThemeMode.system,
              themeMode: ThemeMode.system,
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
        systemUiOverlayStyle(
          MediaQuery.of(context).platformBrightness,
        ),
      );
    }
  }
}
