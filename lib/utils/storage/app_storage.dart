import 'package:shared_preferences/shared_preferences.dart';

/// The few things the app remembers between launches.
///
/// Initialised once from `AppInitializer.init()` before `runApp`. Until that
/// completes every read falls back to its default and writes are dropped —
/// that keeps widgets and tests safe to use without awaiting anything (the
/// boot smoke test pumps the real entry point and never touches prefs).
class AppStorage {
  AppStorage._();

  static SharedPreferences? _prefs;

  /// Load the store. Safe to call more than once.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static const _seenOnboardingKey = 'seen_onboarding';
  static const _isLoggedInKey = 'is_logged_in';
  static const _wishlistKey = 'wishlist_ids';
  static const _recentSearchesKey = 'recent_searches';

  // --- Onboarding ---

  /// Whether the liquid-swipe intro has been completed at least once.
  static bool get seenOnboarding =>
      _prefs?.getBool(_seenOnboardingKey) ?? false;

  static set seenOnboarding(bool value) =>
      _prefs?.setBool(_seenOnboardingKey, value);

  // --- Session ---

  /// Whether the user is signed in, so a relaunch can skip auth entirely.
  static bool get isLoggedIn => _prefs?.getBool(_isLoggedInKey) ?? false;

  static set isLoggedIn(bool value) => _prefs?.setBool(_isLoggedInKey, value);

  // --- Wishlist ---

  /// Hearted product ids, persisted so favourites survive a restart.
  static List<String> get wishlistIds =>
      _prefs?.getStringList(_wishlistKey) ?? const <String>[];

  static set wishlistIds(List<String> value) =>
      _prefs?.setStringList(_wishlistKey, value);

  // --- Search ---

  /// Recent search queries, newest first (capped by the caller).
  static List<String> get recentSearches =>
      _prefs?.getStringList(_recentSearchesKey) ?? const <String>[];

  static set recentSearches(List<String> value) {
    _prefs?.setStringList(_recentSearchesKey, value);
  }
}
