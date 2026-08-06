import 'package:flutter/material.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/theme/custom_themes/text_themes.dart';

class AppTheme {
  AppTheme._();

  ///Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Bricolage Grotesque",
    brightness: Brightness.light,
    primaryColor: AppColors.darkGreen,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme(),
  );

  ///Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Bricolage Grotesque",
    brightness: Brightness.dark,
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: AppTextTheme.darkTextTheme(),
  );
}
