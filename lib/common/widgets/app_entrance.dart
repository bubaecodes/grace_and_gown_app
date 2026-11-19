import 'package:flutter/material.dart';

/// Fades, zooms and lifts [child] in the first time it appears on screen.
///
/// The animation runs automatically when the widget is inserted into the
/// tree, which means it fires in all the places that matter:
///
///  * a screen opening,
///  * a grid swapping from the loading state to its data (the `AppLoadSwitch`
///    in each list screen inserts the subtree once the fetch lands),
///  * new search results appearing as the query changes.
///
/// It is paint-only — opacity, a scale and an 8px translate — so it never
/// affects layout: no reflow, no cards jumping around while they animate,
/// and neighbours never shift position.
///
/// Rebuilds do **not** re-trigger it (the target value never changes), so
/// an `Obx` ticking in the background won't replay the entrance. Only a
/// fresh insertion — a new screen or newly-inserted list items — animates.
///
/// Stagger lists by passing a growing [delay]; see `ProductGrid` for the
/// pattern. The system "remove animations" accessibility setting is
/// respected: when it's on, [child] renders immediately, untouched.
class AppEntrance extends StatelessWidget {
  const AppEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = _kDuration,
    this.scale = 0.92,
    this.rise = 8,
  });

  static const _kDuration = Duration(milliseconds: 280);

  /// How long to wait before this entrance starts — the stagger offset.
  final Duration delay;

  /// How long the fade/zoom itself takes, once [delay] has elapsed.
  final Duration duration;

  /// The widget to animate in.
  final Widget child;

  /// Scale the child starts at, easing up to 1.0.
  final double scale;

  /// How far (in px) the child starts below its final position.
  final double rise;

  @override
  Widget build(BuildContext context) {
    // Accessibility: with "remove animations" on, skip straight to the
    // finished frame.
    if (MediaQuery.disableAnimationsOf(context)) return child;

    // Total = wait + animate. The [Interval] curve holds the child at its
    // start values (invisible, scaled down) for the first `delay` slice,
    // then eases it in over the remaining `duration`.
    final total = delay + duration;
    final startFraction = total.inMicroseconds == 0
        ? 0.0
        : delay.inMicroseconds / total.inMicroseconds;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: total,
      curve: Interval(startFraction, 1, curve: Curves.easeOutCubic),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, rise * (1 - t)),
          child: Transform.scale(scale: scale + (1 - scale) * t, child: child),
        ),
      ),
      child: child,
    );
  }
}
