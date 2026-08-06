import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
  ];
}