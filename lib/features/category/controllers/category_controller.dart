import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/category/data/gown_categories.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

/// State behind the Category tab's card grid.
///
/// Reads the local [GownCategory.all] list for now — `reload()` is shaped so
/// API integration only swaps its body for a real fetch of the category
/// catalogue (`await`, then [LoadState.data]; catch → [LoadState.error]).
class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Where the grid is in its load cycle.
  final Rx<LoadState> state = LoadState.loading.obs;

  /// (Re)loads the category list. See the class doc for the API swap.
  Future<void> reload() async {
    state.value = LoadState.loading;
    try {
      await Future<void>.microtask(() {});
      if (isClosed) return;
      state.value = LoadState.data;
    } catch (_) {
      if (isClosed) return;
      state.value = LoadState.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
    reload();
  }
}
