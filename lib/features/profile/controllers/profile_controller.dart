import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

/// State for the Profile tab.
///
/// The user fields are mock values for now — swap them for a real user
/// source (Firebase Auth, a repository, ...) once one exists. Everything
/// else on the screen reads from here, so only this file needs to change.
class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final Rx<String> name = 'Amara Grace'.obs;
  final Rx<String> email = 'amara.grace@example.com'.obs;
  final Rx<String> phone = '+234 801 234 5678'.obs;

  /// First two initials for the avatar fallback (no image asset yet).
  String get initials {
    final parts = name.value
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .take(2);
    return parts.map((p) => p[0].toUpperCase()).join();
  }

  /// Placeholder for features that aren't built yet.
  void showComingSoon(String feature) {
    CustomSnackBar.showSafe(
      title: feature,
      message: '$feature is coming soon.',
      type: ToastificationType.info,
    );
  }

  /// Sign out and return to the login screen, clearing the nav stack.
  void logout() => Get.offAllNamed(Routes.loginScreen);
}
