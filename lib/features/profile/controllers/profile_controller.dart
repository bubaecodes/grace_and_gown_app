import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';

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

  /// Writes the edited profile fields back onto the reactive state, so the
  /// header card (and anything else reading it) updates immediately.
  /// Validation happens in the edit screen before this is called.
  void saveProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    this.name.value = name;
    this.email.value = email;
    this.phone.value = phone;
  }

  /// Sign out and return to the login screen, clearing the nav stack.
  /// Also clears the persisted session flag so a relaunch lands on login
  /// instead of auto-logging-in.
  void logout() {
    AppStorage.isLoggedIn = false;
    Get.offAllNamed(Routes.loginScreen);
  }
}
