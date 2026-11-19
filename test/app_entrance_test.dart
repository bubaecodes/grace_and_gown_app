import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';

/// Pumps [child] in a MaterialApp. Pass `disableAnimations: true` to
/// simulate the system "remove animations" accessibility setting.
Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  bool disableAnimations = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(
          size: const Size(400, 800),
          disableAnimations: disableAnimations,
        ),
        child: Scaffold(body: Center(child: child)),
      ),
    ),
  );
}

/// The entrance's own opacity layer (scoped so MaterialApp's widgets
/// can't shadow it).
Opacity _opacityOf(WidgetTester tester) => tester.widget<Opacity>(
  find.descendant(of: find.byType(AppEntrance), matching: find.byType(Opacity)),
);

/// The entrance's translate/scale wrappers, as raw matrices.
List<Matrix4> _matricesOf(WidgetTester tester) => [
  for (final t in tester.widgetList<Transform>(
    find.descendant(
      of: find.byType(AppEntrance),
      matching: find.byType(Transform),
    ),
  ))
    t.transform,
];

void main() {
  testWidgets('renders the child immediately, but starts it invisible,', (
    tester,
  ) async {
    await _pump(tester, const AppEntrance(child: Text('CONTENT')));

    // The child is in the tree and laid out from the very first frame —
    // only its paint animates, so neighbours never shift position.
    expect(find.text('CONTENT'), findsOneWidget);
    expect(tester.getSize(find.text('CONTENT')), isNot(Size.zero));

    // First frame: fully faded out, scaled to 0.92, lifted 8px.
    expect(_opacityOf(tester).opacity, 0.0);
    final matrices = _matricesOf(tester);
    expect(
      matrices.any((m) => m.storage[0] > 0.91 && m.storage[0] < 0.93),
      isTrue,
      reason: 'a scale transform must start at 0.92',
    );
    expect(
      matrices.any((m) => m.storage[13] > 7.9 && m.storage[13] < 8.1),
      isTrue,
      reason: 'a translate transform must start 8px high',
    );
  });

  testWidgets('settles at full opacity, scale and rest position', (
    tester,
  ) async {
    await _pump(tester, const AppEntrance(child: Text('CONTENT')));
    // Default duration is 280ms — one pump past it lands at rest.
    await tester.pump(const Duration(milliseconds: 300));

    expect(_opacityOf(tester).opacity, 1.0);
    for (final m in _matricesOf(tester)) {
      expect(
        m.storage[0],
        closeTo(1.0, 1e-9),
        reason: 'scale X must rest at 1',
      );
      expect(
        m.storage[5],
        closeTo(1.0, 1e-9),
        reason: 'scale Y must rest at 1',
      );
      expect(
        m.storage[13],
        closeTo(0.0, 1e-9),
        reason: 'rise must settle at 0',
      );
    }
  });

  testWidgets('a stagger delay holds the child invisible until its slice', (
    tester,
  ) async {
    await _pump(
      tester,
      const AppEntrance(
        delay: Duration(milliseconds: 100),
        child: Text('CONTENT'),
      ),
    );

    // 50ms in: still inside the 100ms delay — the Interval curve keeps
    // the output at exactly 0 (verified against Flutter's Interval docs:
    // "From t=0.0 to t=[begin], the interval's value is 0.0").
    await tester.pump(const Duration(milliseconds: 50));
    expect(_opacityOf(tester).opacity, 0.0);

    // Well past delay + duration (380ms total): at rest.
    await tester.pump(const Duration(milliseconds: 400));
    expect(_opacityOf(tester).opacity, 1.0);
  });

  testWidgets('skips the animation entirely when the system disables '
      'animations', (tester) async {
    await _pump(
      tester,
      const AppEntrance(child: Text('CONTENT')),
      disableAnimations: true,
    );

    // No animation machinery at all — the child renders untouched at
    // full strength on the first frame.
    expect(find.text('CONTENT'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AppEntrance),
        matching: find.byType(TweenAnimationBuilder<double>),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(AppEntrance),
        matching: find.byType(Opacity),
      ),
      findsNothing,
    );
  });
}
