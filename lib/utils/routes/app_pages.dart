import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/auth/login/screens/login_screen.dart';
import 'package:grace_and_gown_app/features/auth/onboarding/screens/onboarding_screen.dart';
import 'package:grace_and_gown_app/features/auth/password/confirm_password/screens/confirm_password_screen.dart';
import 'package:grace_and_gown_app/features/auth/password/forgot_password/screens/forgot_password_screen.dart';
import 'package:grace_and_gown_app/features/auth/password/verify_email/screens/verify_email_screen.dart';
import 'package:grace_and_gown_app/features/auth/password/reset_link/screens/reset_link_screen.dart';
import 'package:grace_and_gown_app/features/auth/signup/screens/signup_screen.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signupScreen,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.resetLinkScreen,
      page: () => const ResetLinkScreen(),
    ),
    GetPage(
      name: Routes.confirmPasswordScreen,
      page: () => const ConfirmPasswordScreen(),
    ),
    GetPage(
      name: Routes.verifyEmailScreen,
      page: () => const VerifyEmailScreen(),
    ),
  ];
}