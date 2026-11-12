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
    scaffoldBackgroundColor: AppColors.cardBg,
    textTheme: AppTextTheme.lightTextTheme(),
    colorScheme: const ColorScheme.light(
      primary: AppColors.darkGreen,
      onPrimary: AppColors.white,
      secondary: AppColors.sageGreen,
      onSecondary: AppColors.darkGreen,
      surface: AppColors.cardBg,
      onSurface: AppColors.black,
      outline: AppColors.primaryGreen,
      error: AppColors.error,
      onError: AppColors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryGreen,
      selectionColor: AppColors.sageGreen,
      selectionHandleColor: AppColors.primaryGreen,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkSageGreen,
      thickness: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
    ),
  );

  ///Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Bricolage Grotesque",
    brightness: Brightness.dark,
    primaryColor: AppColors.sageGreen,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: AppTextTheme.darkTextTheme(),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.sageGreen,
      onPrimary: AppColors.dark,
      secondary: AppColors.darkSageGreen,
      onSecondary: AppColors.white,
      surface: AppColors.darkCard,
      onSurface: AppColors.white,
      outline: AppColors.oliveGreen,
      error: AppColors.error,
      onError: AppColors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.sageGreen,
      selectionColor: AppColors.oliveGreen,
      selectionHandleColor: AppColors.sageGreen,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkSageGreen,
      thickness: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkCard,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.darkCard,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
