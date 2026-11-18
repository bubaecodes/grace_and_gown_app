import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/home/screens/home_screen.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/features/search/controllers/search_screen_controller.dart';
import 'package:grace_and_gown_app/features/search/screens/search_screen.dart';
import 'package:grace_and_gown_app/features/shop/products/screens/product_details_screen.dart';
import 'package:grace_and_gown_app/utils/routes/app_pages.dart';
import 'package:grace_and_gown_app/utils/storage/app_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpHome(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      // The real route table, so a missing GetPage fails the same way it
      // fails on the user's device.
      builder: (_, _) => GetMaterialApp(
        home: const HomeScreen(),
        getPages: AppPages.pages,
      ),
    ),
  );
  // Flush the home controller's loading → data microtask so the grid is up.
  await tester.pump(const Duration(seconds: 1));
}

/// Taps the home field, which must push the full Search screen.
Future<void> _openSearch(WidgetTester tester) async {
  await tester.tap(find.text('Search by name or category'));
  await tester.pumpAndSettle();

  expect(find.byType(SearchScreen), findsOneWidget);
}

void main() {
  setUp(() async {
    Get.reset();
    // AppStorage silently no-ops without a backing store, so the recents
    // persistence assertions below need the mock store first.
    SharedPreferences.setMockInitialValues({});
    await AppStorage.init();
    AppStorage.recentSearches = const [];
  });

  testWidgets('tapping the home field opens the search screen',
      (tester) async {
    await _pumpHome(tester);
    expect(find.byType(SearchScreen), findsNothing);

    await _openSearch(tester);

    // Focused input, no results yet — the recents empty state shows.
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search the catalogue'), findsOneWidget);
    expect(find.text('Recent searches'), findsNothing);
  });

  testWidgets('typing filters the results live', (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'lace');
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('1 result for "lace"'), findsOneWidget);
    expect(find.text('Aurelia Lace Gown'), findsOneWidget);
    // Present on the unfiltered home grid, so this proves the filter ran.
    expect(find.text('Odette Ball Gown'), findsNothing);
  });

  testWidgets('an unmatched query shows the no-results state', (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'zzzz');
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('No gowns match "zzzz"'), findsOneWidget);
    expect(find.byType(ProductGrid), findsNothing);
  });

  testWidgets('submitting a query files it in the recent searches',
      (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'lace');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(SearchScreenController.instance.recents, contains('lace'));
    expect(AppStorage.recentSearches, contains('lace'));

    // Clearing the field reveals the recents list, newest first.
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();

    expect(find.text('Recent searches'), findsOneWidget);
    expect(find.text('lace'), findsOneWidget);
    expect(find.text('Clear all'), findsOneWidget);
  });

  testWidgets('a repeat query moves to the top instead of duplicating',
      (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    for (final query in ['lace', 'white', 'lace']) {
      await tester.enterText(find.byType(TextField), query);
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
    }

    final recents = SearchScreenController.instance.recents;
    expect(recents.toList(), ['lace', 'white']);
    expect(AppStorage.recentSearches, ['lace', 'white']);
  });

  testWidgets('clearing the recents empties storage too', (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'lace');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();

    await tester.tap(find.text('Clear all'));
    await tester.pump();

    expect(SearchScreenController.instance.recents, isEmpty);
    expect(AppStorage.recentSearches, isEmpty);
    // No recents left, so the idle empty state takes over.
    expect(find.text('Search the catalogue'), findsOneWidget);
    expect(find.text('Recent searches'), findsNothing);
  });

  testWidgets('tapping a result opens the product and files the query',
      (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'lace');
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('Aurelia Lace Gown'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailScreen), findsOneWidget);
    expect(AppStorage.recentSearches, contains('lace'));
  });

  testWidgets('the query typed here is what Home shows on return',
      (tester) async {
    await _pumpHome(tester);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'lace');
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(SearchScreen), findsNothing);
    // Home's fake field mirrors the shared query, and the grid is filtered
    // by the same value — one source of truth for both screens.
    expect(find.text('lace'), findsOneWidget);
    expect(find.text('Aurelia Lace Gown'), findsOneWidget);
    expect(find.text('Odette Ball Gown'), findsNothing);
  });
}
