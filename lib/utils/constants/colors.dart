import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  ///Background Colors
  static const Color darkGreen = Color(0xFF1F4401);
  static const Color primaryGreen = Color(0xFF464631);
  static const Color darkSageGreen = Color(0xFF959572);
  static const Color sageGreen = Color(0xFFA8AE84);
  static const Color oliveGreen = Color(0xFF7D805F);
  static const Color softBeige = Color(0xFFDDD7CF);
  static const Color warmBeige = Color(0xFFCEC0AF);
  static const Color darkBeige = Color(0xFFBAAA95);

  /// text colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFEBEAE5);
  static const Color black = Color(0xFF000000);
  static const Color dark = Color(0xFF181818);
  static const Color grey = Color(0xFF6F6F6F);

  /// Elevated surface for dark mode, derived from [dark] so cards, sheets
  /// and text fields sit slightly above the dark scaffold background.
  static const Color darkCard = Color(0xFF242424);


  /// validations
  static const Color warning = Color(0xFFF9A825);
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);

  ///----------------------------------------------------------------///
  ///  Brightness-aware semantic colors
  ///
  ///  Widgets should use these instead of the raw palette entries so the
  ///  same code renders correctly in light AND dark mode. Every value is
  ///  still taken from the app palette above.
  ///----------------------------------------------------------------///

  /// true when the active theme is dark
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Display / screen titles (the Prata headings).
  /// [primaryGreen] is near-black, so dark mode swaps it for [softBeige].
  static Color heading(BuildContext context) =>
      isDark(context) ? softBeige : primaryGreen;

  /// Secondary text: sub headers, captions, hints (replaces [grey]).
  static Color secondary(BuildContext context) =>
      isDark(context) ? darkSageGreen : grey;

  /// Tappable / inline link text (replaces [darkGreen]).
  static Color link(BuildContext context) =>
      isDark(context) ? sageGreen : darkGreen;

  /// Strong text that must stay readable on a field or card: typed input
  /// (replaces [primaryGreen], which is too dark on a dark surface).
  static Color strong(BuildContext context) =>
      isDark(context) ? white : primaryGreen;

  /// Emphasised inline text: email addresses, "Resend", "Login" links
  /// (replaces [primaryGreen] when used as text).
  static Color accentText(BuildContext context) =>
      isDark(context) ? sageGreen : primaryGreen;

  /// Outlines and icons: field borders, button borders, leading icons
  /// (replaces [primaryGreen], which is invisible on a dark background).
  static Color accent(BuildContext context) =>
      isDark(context) ? oliveGreen : primaryGreen;

  /// Fill behind text fields and OTP boxes.
  static Color fieldFill(BuildContext context) =>
      isDark(context)
          ? sageGreen.withValues(alpha: 0.14)
          : sageGreen.withValues(alpha: 0.34);

  /// Background of the auth screens ([cardBg] in light mode).
  static Color authScaffold(BuildContext context) =>
      isDark(context) ? dark : cardBg;

  /// Brand-tinted background used by onboarding ([softBeige] in light mode).
  static Color beigeScaffold(BuildContext context) =>
      isDark(context) ? dark : softBeige;

  /// Plain background: splash screen ([white] in light mode).
  static Color plainScaffold(BuildContext context) =>
      isDark(context) ? dark : white;

  /// Background for bottom sheets, dialogs and cards.
  static Color elevatedSurface(BuildContext context) =>
      isDark(context) ? darkCard : white;
}
