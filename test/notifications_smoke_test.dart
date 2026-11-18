import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/home/screens/home_screen.dart';
import 'package:grace_and_gown_app/features/profile/controllers/notifications_controller.dart';
import 'package:grace_and_gown_app/features/profile/screens/notifications_screen.dart';
import 'package:grace_and_gown_app/utils/routes/app_pages.dart';

Future<void> _pump(WidgetTester tester, {required Widget home}) async {
  tester.view.physicalSize = const Size(440 * 3, 976 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => GetMaterialApp(
        home: home,
        getPages: AppPages.pages,
      ),
    ),
  );
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  // GetX registrations outlive a single testWidgets body, so reset to the
  // seeded state instead of inheriting whatever the last test left behind.
  setUp(() => Get.reset());

  testWidgets('renders the seeded notifications', (tester) async {
    await _pump(tester, home: const NotificationsScreen());

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Fitting confirmed'), findsOneWidget);
    expect(find.text('Payment received'), findsOneWidget);
    expect(find.text('New arrivals'), findsOneWidget);
    expect(NotificationsController.instance.unreadCount, 2);
  });

  testWidgets('mark all read clears every unread dot', (tester) async {
    await _pump(tester, home: const NotificationsScreen());

    expect(find.text('Mark all read'), findsOneWidget);

    await tester.tap(find.text('Mark all read'));
    await tester.pump();

    expect(NotificationsController.instance.unreadCount, 0);
    // Nothing left to mark, so the action hides itself.
    expect(find.text('Mark all read'), findsNothing);
    expect(find.text('Clear'), findsOneWidget);
  });

  testWidgets('tapping a tile marks just that entry as read', (tester) async {
    await _pump(tester, home: const NotificationsScreen());

    final controller = NotificationsController.instance;
    expect(controller.unreadCount, 2);

    await tester.tap(find.text('Fitting confirmed'));
    await tester.pump();

    expect(controller.unreadCount, 1);
    expect(controller.items.first.read, isTrue);
    // One unread left, so "Mark all read" is still offered.
    expect(find.text('Mark all read'), findsOneWidget);
  });

  testWidgets('clearing everything shows the empty state', (tester) async {
    await _pump(tester, home: const NotificationsScreen());

    await tester.tap(find.text('Clear'));
    await tester.pump();

    expect(find.text('You\'re all caught up'), findsOneWidget);
    expect(NotificationsController.instance.items, isEmpty);
    expect(find.text('Clear'), findsNothing);
  });

  testWidgets('the home header bell opens the notifications screen',
      (tester) async {
    await _pump(tester, home: const HomeScreen());

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationsScreen), findsOneWidget);
  });
}
