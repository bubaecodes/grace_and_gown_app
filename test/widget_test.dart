// Boot smoke test — the app's entry point (`MyApp` in main.dart) through
// the splash → onboarding hand-off.
//
// Every other test builds its own harness; this one is here to catch the
// two things they can't: whether the real wrapper stack
// (ToastificationWrapper / OverlaySupport / ScreenUtilInit / GetMaterialApp
// with the route table) still boots, and whether the app still lands where
// the user expects after the splash timer.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grace_and_gown_app/features/auth/onboarding/screens/onboarding_screen.dart';
import 'package:grace_and_gown_app/features/auth/splash/screens/splash_screen.dart';
import 'package:grace_and_gown_app/main.dart';

void main() {
  testWidgets('app boots to splash, then hands off to onboarding',
      (tester) async {
    // Match the design size the app uses on a phone (see main_app.dart).
    tester.view.physicalSize = const Size(440 * 3, 976 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // The splash renders first, with nothing else on screen.
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    // SplashController waits 6s before `Get.offAllNamed(onboarding)`.
    //
    // Deliberately `pump(Duration)` and not `pumpAndSettle`: the splash
    // runs a 5s scale animation, so settle would spin for its whole
    // duration — and would hang entirely if anything keeps ticking.
    await tester.pump(const Duration(seconds: 7));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
