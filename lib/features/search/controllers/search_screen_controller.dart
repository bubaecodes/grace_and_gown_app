import 'package:get/get.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';

/// Recent-search list behind the Search screen.
///
/// Persisted through [AppStorage.recentSearches], so queries survive a
/// relaunch. Newest first, case-insensitively deduped, capped at [_cap].
class SearchScreenController extends GetxController {
  static SearchScreenController get instance => Get.find();

  /// How many queries are kept.
  static const _cap = 8;

  /// Newest-first list of past queries.
  final RxList<String> recents = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    recents.assignAll(AppStorage.recentSearches);
  }

  /// Moves [query] to the top of the list — trimmed, empty ignored, a repeat
  /// of an existing entry moves it rather than duplicating it, list capped at
  /// [_cap] — then persists the result.
  void addRecent(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    recents.removeWhere((q) => q.toLowerCase() == trimmed.toLowerCase());
    recents.insert(0, trimmed);
    if (recents.length > _cap) {
      recents.removeRange(_cap, recents.length);
    }
    _persist();
  }

  /// Header action — empties the list (which reveals the "start typing"
  /// empty state) and forgets the stored copy.
  void clearRecents() {
    recents.clear();
    _persist();
  }

  /// Writes the list back to storage. `AppStorage` no-ops when its backing
  /// store was never initialised (tests, early boot), which is fine — the
  /// in-memory list stays correct either way.
  void _persist() => AppStorage.recentSearches = recents.toList();
}
