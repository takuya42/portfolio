import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'sans-serif',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.ink,
          fontSize: 52,
          height: 1.35,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
        headlineLarge: TextStyle(
          color: AppColors.ink,
          fontSize: 36,
          height: 1.45,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: TextStyle(
          color: AppColors.ink,
          fontSize: 26,
          height: 1.45,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: AppColors.ink,
          fontSize: 21,
          height: 1.5,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: AppColors.body,
          fontSize: 17,
          height: 1.9,
        ),
        bodyMedium: TextStyle(
          color: AppColors.body,
          fontSize: 15,
          height: 1.8,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 54),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 54),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
