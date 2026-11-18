class Routes {
  static const splashScreen = '/';
  static const onboardingScreen = '/onboarding-screen';

  ///-----------------AUTH SCREENS-------------------------///
  static const loginScreen = '/login-screen';
  static const signupScreen = '/signup-screen';
  static const forgotPasswordScreen = '/forgot-password-screen';
  static const resetLinkScreen = '/reset-link-screen';
  static const confirmPasswordScreen = '/confirm-password-screen';
  static const verifyEmailScreen = '/verify-email-screen';

  static const dashboardScreen = '/dashboard-screen';
  static const productDetailScreen = '/product-detail-screen';

  /// Product list for one category — takes a `GownCategory` as arguments.
  static const categoryProductsScreen = '/category-products-screen';

  /// Booking fee checkout — the ₦20,000 hold charge before a visit exists.
  static const paymentScreen = '/payment-screen';

  /// Full-screen search — live results over the catalogue plus the
  /// user's recent queries.
  static const searchScreen = '/search-screen';

  /// Everything about one visit — reference, slot, fee receipt.
  static const bookingDetailsScreen = '/booking-details-screen';

  ///----------------- PROFILE SUB-SCREENS-------------------------///
  static const editProfileScreen = '/edit-profile-screen';
  static const addressesScreen = '/addresses-screen';
  static const paymentMethodsScreen = '/payment-methods-screen';
  static const helpCenterScreen = '/help-center-screen';
  static const contactUsScreen = '/contact-us-screen';
  static const aboutScreen = '/about-screen';
  static const notificationsScreen = '/notifications-screen';
  static const privacySecurityScreen = '/privacy-security-screen';
}