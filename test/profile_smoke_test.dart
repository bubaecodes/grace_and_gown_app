import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/profile/screens/profile_screen.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

Future<void> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(
        home: const ProfileScreen(),
        // Stub for the logout destination — the real LoginScreen needs
        // assets and more setup than this smoke test should pull in.
        getPages: [
          GetPage(
            name: Routes.loginScreen,
            page: () => const Scaffold(body: Center(child: Text('Login'))),
          ),
        ],
      ),
    ),
  );
}

void main() {
  testWidgets('profile screen renders mock user and menu sections',
      (tester) async {
    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Amara Grace'), findsOneWidget);
    expect(find.text('amara.grace@example.com'), findsOneWidget);

    expect(find.text('ACCOUNT'), findsOneWidget);
    expect(find.text('My Details'), findsOneWidget);
    expect(find.text('Addresses'), findsOneWidget);
    expect(find.text('Payment Methods'), findsOneWidget);

    expect(find.text('SUPPORT'), findsOneWidget);
    expect(find.text('Help Center'), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('Privacy & Security'), findsOneWidget);

    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('logout asks for confirmation before signing out',
      (tester) async {
    await _pump(tester);
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    // Confirmation dialog appears first.
    expect(find.text('Are you sure you want to logout?'), findsOneWidget);

    // Confirm → leaves the dashboard for the login screen.
    // `.last` picks the dialog's action over the button behind it.
    await tester.tap(find.text('Logout').last);
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to logout?'), findsNothing);
    expect(find.text('Login'), findsOneWidget);
  });
}
