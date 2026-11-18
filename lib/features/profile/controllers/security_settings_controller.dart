import 'package:get/get.dart';

/// Toggles on the Privacy & Security screen.
///
/// Mock state for now — wire each flag to real storage / the backend once
/// those exist.
class SecuritySettingsController extends GetxController {
  static SecuritySettingsController get instance => Get.find();

  /// Require fingerprint / face unlock when the app is reopened.
  final RxBool biometricLock = false.obs;

  /// Promo, new-arrival and style emails.
  final RxBool marketingEmails = true.obs;

  /// Booking, delivery and pickup updates.
  final RxBool orderUpdates = true.obs;
}
