import 'package:flutter_test/flutter_test.dart';
import 'package:grace_and_gown_app/utils/routes/app_pages.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// Every route a button can push must have a matching GetPage — a missing
/// entry is invisible to the analyzer and the tests, and only shows up as a
/// "Route not found" error when the user taps the button.
///
/// `splashScreen` is deliberately absent: the boot route `'/'` is served by
/// `home: SplashScreen()` in MainApp. `searchScreen` and
/// `bookingDetailsScreen` are future screens no button navigates to yet.
void main() {
  test('every navigable route is registered in AppPages', () {
    final registered = AppPages.pages.map((page) => page.name).toSet();

    const expected = [
      // Auth
      Routes.onboardingScreen,
      Routes.loginScreen,
      Routes.signupScreen,
      Routes.forgotPasswordScreen,
      Routes.resetLinkScreen,
      Routes.confirmPasswordScreen,
      Routes.verifyEmailScreen,
      // App
      Routes.dashboardScreen,
      Routes.productDetailScreen,
      Routes.categoryProductsScreen,
      Routes.paymentScreen,
      // Profile sub-screens
      Routes.editProfileScreen,
      Routes.addressesScreen,
      Routes.paymentMethodsScreen,
      Routes.helpCenterScreen,
      Routes.contactUsScreen,
      Routes.aboutScreen,
      Routes.notificationsScreen,
      Routes.privacySecurityScreen,
    ];

    for (final name in expected) {
      expect(
        registered,
        contains(name),
        reason: '$name has no GetPage — Get.toNamed($name) throws '
            '"Route not found" at runtime.',
      );
    }
  });

  test('no route is registered twice', () {
    final names = AppPages.pages.map((page) => page.name).toList();

    expect(names.toSet().length, names.length,
        reason: 'Duplicate GetPage names shadow each other.');
  });
}
