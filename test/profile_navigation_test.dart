import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/screens/about_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/addresses_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/contact_us_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/edit_profile_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/help_center_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/notifications_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/payment_methods_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/privacy_security_screen.dart';
import 'package:grace_and_gown_app/features/profile/screens/profile_screen.dart';
import 'package:grace_and_gown_app/utils/routes/app_pages.dart';

Future<void> _pumpProfile(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  // The real route table, so a missing GetPage fails the same way it
  // fails on the user's device.
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(
        home: const ProfileScreen(),
        getPages: AppPages.pages,
      ),
    ),
  );
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  // Menu label → the screen its row must push.
  final menuScreens = <String, Type>{
    'My Details': EditProfileScreen,
    'Addresses': AddressesScreen,
    'Payment Methods': PaymentMethodsScreen,
    'Help Center': HelpCenterScreen,
    'Contact Us': ContactUsScreen,
    'About': AboutScreen,
    'Notifications': NotificationsScreen,
    'Privacy & Security': PrivacySecurityScreen,
  };

  testWidgets('every profile menu row pushes its screen', (tester) async {
    await _pumpProfile(tester);

    for (final entry in menuScreens.entries) {
      await tester.tap(find.text(entry.key));
      await tester.pumpAndSettle();

      expect(
        find.byType(entry.value),
        findsOneWidget,
        reason: 'Tapping "${entry.key}" must push ${entry.value} — its '
            'route is missing from AppPages or the screen failed to build.',
      );

      // Back to the menu for the next row.
      Get.back();
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
    }
  });
}
