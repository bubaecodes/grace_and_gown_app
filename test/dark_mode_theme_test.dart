import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/theme/theme.dart';

/// Pumps a minimal app on [mode] and hands the themed context to [verify].
Future<void> pumpWithMode(
  WidgetTester tester,
  ThemeMode mode,
  void Function(BuildContext ctx) verify,
) async {
  late BuildContext ctx;

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: mode,
        home: Builder(
          builder: (context) {
            ctx = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  await tester.pump();

  verify(ctx);
}

void main() {
  testWidgets('dark mode resolves every semantic color to the dark palette',
      (tester) async {
    await pumpWithMode(tester, ThemeMode.dark, (ctx) {
      expect(AppColors.isDark(ctx), isTrue);
      expect(Theme.of(ctx).scaffoldBackgroundColor, AppColors.dark);

      /// Screens
      expect(AppColors.authScaffold(ctx), AppColors.dark);
      expect(AppColors.beigeScaffold(ctx), AppColors.dark);
      expect(AppColors.plainScaffold(ctx), AppColors.dark);

      /// Surfaces
      expect(AppColors.elevatedSurface(ctx), AppColors.darkCard);

      /// Text: primaryGreen/darkGreen are near-black, so dark mode must swap
      /// them out or headings and links become invisible.
      expect(AppColors.heading(ctx), AppColors.softBeige);
      expect(AppColors.secondary(ctx), AppColors.darkSageGreen);
      expect(AppColors.link(ctx), AppColors.sageGreen);
      expect(AppColors.accentText(ctx), AppColors.sageGreen);
      expect(AppColors.strong(ctx), AppColors.white);

      /// Structure
      expect(AppColors.accent(ctx), AppColors.oliveGreen);

      /// Field fill is dimmer on dark so it doesn't glow.
      expect(
        AppColors.fieldFill(ctx).a,
        closeTo(AppColors.sageGreen.a * 0.14, 0.001),
      );
    });
  });

  testWidgets('light mode keeps the exact colors the app shipped with',
      (tester) async {
    await pumpWithMode(tester, ThemeMode.light, (ctx) {
      expect(AppColors.isDark(ctx), isFalse);
      expect(Theme.of(ctx).scaffoldBackgroundColor, AppColors.cardBg);

      expect(AppColors.authScaffold(ctx), AppColors.cardBg);
      expect(AppColors.beigeScaffold(ctx), AppColors.softBeige);
      expect(AppColors.plainScaffold(ctx), AppColors.white);
      expect(AppColors.elevatedSurface(ctx), AppColors.white);

      expect(AppColors.heading(ctx), AppColors.primaryGreen);
      expect(AppColors.secondary(ctx), AppColors.grey);
      expect(AppColors.link(ctx), AppColors.darkGreen);
      expect(AppColors.accentText(ctx), AppColors.primaryGreen);
      expect(AppColors.strong(ctx), AppColors.primaryGreen);
      expect(AppColors.accent(ctx), AppColors.primaryGreen);

      expect(
        AppColors.fieldFill(ctx).a,
        closeTo(AppColors.sageGreen.a * 0.34, 0.001),
      );
    });
  });
}
