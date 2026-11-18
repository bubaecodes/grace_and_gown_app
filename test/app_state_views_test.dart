import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/utils/states/load_state.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
}

Widget _switch(LoadState state, VoidCallback onRetry) => AppLoadSwitch(
      state: state,
      onRetry: onRetry,
      data: (context) => const Text('REAL CONTENT'),
    );

void main() {
  testWidgets('loading shows the spinner instead of the data', (tester) async {
    await _pump(tester, _switch(LoadState.loading, () {}));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('REAL CONTENT'), findsNothing);
    // The spinner animates forever — pump, never pumpAndSettle, here.
  });

  testWidgets('error shows the retry button and fires its callback',
      (tester) async {
    var retried = false;
    await _pump(tester, _switch(LoadState.error, () => retried = true));

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('REAL CONTENT'), findsNothing);

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(retried, isTrue, reason: 'The retry button must call onRetry.');
  });

  testWidgets('error honours a custom message', (tester) async {
    await _pump(
      tester,
      AppLoadSwitch(
        state: LoadState.error,
        onRetry: () {},
        errorMessage: 'The wifi gave up.',
        data: (context) => const Text('REAL CONTENT'),
      ),
    );

    // The heading stays fixed; only the detail line is overridden, and the
    // generic fallback must not appear alongside it.
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('The wifi gave up.'), findsOneWidget);
    expect(
      find.textContaining('Check your connection'),
      findsNothing,
    );
  });

  testWidgets('data builds the screen content', (tester) async {
    await _pump(tester, _switch(LoadState.data, () {}));

    expect(find.text('REAL CONTENT'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Try again'), findsNothing);
  });

  testWidgets('empty view renders its title and subtitle', (tester) async {
    await _pump(
      tester,
      const AppEmptyView(
        icon: Icons.search_rounded,
        title: 'Search the catalogue',
        subtitle: 'Find gowns by name or category.',
      ),
    );

    expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    expect(find.text('Search the catalogue'), findsOneWidget);
    expect(find.text('Find gowns by name or category.'), findsOneWidget);
  });

  testWidgets('empty view works without a subtitle', (tester) async {
    await _pump(tester, const AppEmptyView(title: 'Nothing here'));

    expect(find.text('Nothing here'), findsOneWidget);
  });
}
