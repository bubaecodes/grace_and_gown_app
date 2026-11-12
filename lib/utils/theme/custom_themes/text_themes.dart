// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SmlTextTheme {
//   SmlTextTheme._();
//
//   /// Customizable Dart Text Theme
//   static TextTheme lightTextTheme = TextTheme(
//     headlineLarge: const TextStyle().copyWith(fontSize: 30.sp, fontWeight: FontWeight.w600, color: Colors.black),
//     headlineMedium: const TextStyle().copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500, color: Colors.black),
//     headlineSmall: const TextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.black),
//
//     titleLarge: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black),
//     titleMedium: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
//     titleSmall: const TextStyle().copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.black),
//
//     bodyLarge: const TextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black),
//     bodyMedium: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
//     bodySmall: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
//
//     labelLarge: const TextStyle().copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.black),
//     labelMedium: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
//     labelSmall: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
//
//     //displaySmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
//   );
//
//
//   /// Customizable Dart Text Theme
//   static TextTheme darkTextTheme = TextTheme(
//     headlineLarge: const TextStyle().copyWith(fontSize: 30.sp, fontWeight: FontWeight.w600, color: Colors.white),
//     headlineMedium: const TextStyle().copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500, color: Colors.white),
//     headlineSmall: const TextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.white),
//
//     titleLarge: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
//     titleMedium: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
//     titleSmall: const TextStyle().copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white),
//
//     bodyLarge: const TextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white),
//     bodyMedium: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
//     bodySmall: const TextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white),
//
//     labelLarge: const TextStyle().copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.white),
//     labelMedium: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
//     labelSmall: const TextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
//
//     //displaySmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static const _font = 'Bricolage Grotesque';

  static TextStyle _light(double size, FontWeight weight, [Color color = Colors.black]) =>
      TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: color);

  static TextStyle _dark(double size, FontWeight weight, [Color color = AppColors.white]) =>
      TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: color);

  static TextTheme lightTextTheme() => TextTheme(
    headlineLarge:  _light(30.sp, FontWeight.w600),
    headlineMedium: _light(24.sp, FontWeight.w500),
    headlineSmall:  _light(20.sp, FontWeight.w500),
    titleLarge:     _light(16.sp, FontWeight.w700),
    titleMedium:    _light(14.sp, FontWeight.w600),
    titleSmall:     _light(10.sp, FontWeight.w500),
    bodyLarge:      _light(20.sp, FontWeight.w600),
    bodyMedium:     _light(14.sp, FontWeight.w500),
    bodySmall:      _light(14.sp, FontWeight.w400),
    labelLarge:     _light(24.sp, FontWeight.w600),
    labelMedium:    _light(16.sp, FontWeight.w600),
    labelSmall:     _light(16.sp, FontWeight.w500),
  );

  /// Dark mode: titles use [AppColors.softBeige] (a warm off-white that reads
  /// as a heading on the dark scaffold), body/label text stays white.
  static TextTheme darkTextTheme() => TextTheme(
    headlineLarge:  _dark(30.sp, FontWeight.w600, AppColors.softBeige),
    headlineMedium: _dark(24.sp, FontWeight.w500, AppColors.softBeige),
    headlineSmall:  _dark(20.sp, FontWeight.w500, AppColors.softBeige),
    titleLarge:     _dark(16.sp, FontWeight.w700, AppColors.softBeige),
    titleMedium:    _dark(14.sp, FontWeight.w600, AppColors.softBeige),
    titleSmall:     _dark(10.sp, FontWeight.w500, AppColors.softBeige),
    bodyLarge:      _dark(20.sp, FontWeight.w600),
    bodyMedium:     _dark(14.sp, FontWeight.w500),
    bodySmall:      _dark(14.sp, FontWeight.w400),
    labelLarge:     _dark(24.sp, FontWeight.w600),
    labelMedium:    _dark(16.sp, FontWeight.w600),
    labelSmall:     _dark(16.sp, FontWeight.w500),
  );
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SmlTextTheme {
//   SmlTextTheme._();
//
//   static const _font = 'Bricolage Grotesque';
//
//   static TextStyle _light(double size, FontWeight weight, [Color color = Colors.black]) =>
//       TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: color);
//
//   static TextStyle _dark(double size, FontWeight weight) =>
//       TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: Colors.white);
//
//   static TextTheme lightTextTheme = TextTheme(
//     headlineLarge:  _light(30.sp, FontWeight.w600),
//     headlineMedium: _light(24.sp, FontWeight.w500),
//     headlineSmall:  _light(20.sp, FontWeight.w500),
//
//     titleLarge:  _light(16.sp, FontWeight.w700),
//     titleMedium: _light(14.sp, FontWeight.w600),
//     titleSmall:  _light(10.sp, FontWeight.w500),
//
//     bodyLarge:  _light(20.sp, FontWeight.w600),
//     bodyMedium: _light(14.sp, FontWeight.w500),
//     bodySmall:  _light(14.sp, FontWeight.w400),
//
//     labelLarge:  _light(24.sp, FontWeight.w600),
//     labelMedium: _light(16.sp, FontWeight.w600),
//     labelSmall:  _light(16.sp, FontWeight.w500),
//   );
//
//   static TextTheme darkTextTheme = TextTheme(
//     headlineLarge:  _dark(30.sp, FontWeight.w600),
//     headlineMedium: _dark(24.sp, FontWeight.w500),
//     headlineSmall:  _dark(20.sp, FontWeight.w500),
//
//     titleLarge:  _dark(16.sp, FontWeight.w700),
//     titleMedium: _dark(14.sp, FontWeight.w600),
//     titleSmall:  _dark(10.sp, FontWeight.w500),
//
//     bodyLarge:  _dark(20.sp, FontWeight.w600),
//     bodyMedium: _dark(14.sp, FontWeight.w500),
//     bodySmall:  _dark(14.sp, FontWeight.w400),
//
//     labelLarge:  _dark(24.sp, FontWeight.w600),
//     labelMedium: _dark(16.sp, FontWeight.w600),
//     labelSmall:  _dark(16.sp, FontWeight.w500),
//   );
// }