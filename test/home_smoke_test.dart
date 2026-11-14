import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:grace_and_gown_app/features/home/screens/home_screen.dart';

Future<void> _pump(WidgetTester tester, {required Widget home}) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(home: home),
    ),
  );
}

void main() {
  testWidgets('dashboard renders the home tab', (tester) async {
    await _pump(tester, home: const DashboardScreen());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Find Your Perfect Gown'), findsOneWidget);
    expect(find.text('Aurelia Lace Gown'), findsOneWidget);
    expect(find.text('Search by name or category'), findsOneWidget);
  });

  testWidgets('home screen renders on its own', (tester) async {
    await _pump(tester, home: const HomeScreen());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Find Your Perfect Gown'), findsOneWidget);
    expect(find.text('Aurelia Lace Gown'), findsOneWidget);
  });
}
