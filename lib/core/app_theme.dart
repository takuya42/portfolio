import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      primary: AppColors.charcoal,
      surface: AppColors.white,
    ),
    fontFamily: 'sans-serif',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 62,
        height: 1.25,
        fontWeight: FontWeight.w300,
        letterSpacing: 2,
        color: AppColors.charcoal,
      ),
      headlineLarge: TextStyle(
        fontSize: 39,
        height: 1.4,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.4,
        color: AppColors.charcoal,
      ),
      headlineMedium: TextStyle(
        fontSize: 29,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: AppColors.charcoal,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.charcoal,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 2, color: AppColors.body),
      bodyMedium: TextStyle(fontSize: 14, height: 1.8, color: AppColors.body),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.charcoal,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 56),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.charcoal,
        minimumSize: const Size(0, 56),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        side: const BorderSide(color: AppColors.charcoal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),
  );
}
