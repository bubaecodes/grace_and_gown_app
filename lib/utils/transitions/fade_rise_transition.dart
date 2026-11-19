import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Push transition for every screen: the incoming page fades in while
/// rising ~2% of its height (~16-20px on a phone), easing out.
///
/// Subtle on purpose — it should read as "the screen arrived", not as a
/// special effect. Pairs with the `AppEntrance` staggers used inside the
/// screens themselves. On pop the same curve runs backwards, so the page
/// settles back down as it fades out.
///
/// Wired in once, globally, via `GetMaterialApp(customTransition: ...)` in
/// `main_app.dart` — GetX routes that don't set their own `transition`
/// fall through to this (confirmed against get-4.7.3's
/// `GetTransitionMixin.buildTransitions`, which only reaches
/// `Get.customTransition` while `route.transition` and `Get.defaultTransition`
/// are both null — neither is ever set in this app).
class FadeRiseTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // GetX passes the route's curve in, but `GetPage.curve` defaults to
    // `Curves.linear` (it's never null), so treat that default as "no curve
    // chosen" and apply ours — while still honouring a route that sets one.
    final effectiveCurve = (curve == null || curve == Curves.linear)
        ? Curves.easeOutCubic
        : curve;
    final curved = CurvedAnimation(parent: animation, curve: effectiveCurve);

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        // 2% of the page height ≈ 16-20px on a phone — a lift, not a slide.
        position: Tween<Offset>(
          begin: const Offset(0, 0.02),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
