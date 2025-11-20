import 'package:flutter/material.dart';
import 'package:ub_t/core/theme/app_pallete.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPallete.primarySkyBlue,
      primary: AppPallete.primarySkyBlue,
      secondary: AppPallete.lightSkyBlue,
      error: AppPallete.errorColor,
      surface: AppPallete.surfaceColor,
      background: AppPallete.backgroundColor,
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.primarySkyBlue,
      foregroundColor: AppPallete.white,
      elevation: 0,
      centerTitle: true,
    ),
    
    cardTheme: CardThemeData(
      color: AppPallete.surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.primarySkyBlue,
        foregroundColor: AppPallete.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppPallete.primarySkyBlue,
        side: const BorderSide(color: AppPallete.primarySkyBlue, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPallete.surfaceColor,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppPallete.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppPallete.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppPallete.primarySkyBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppPallete.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppPallete.errorColor, width: 2),
      ),
    ),
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPallete.primarySkyBlue,
      foregroundColor: AppPallete.white,
    ),
    
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppPallete.textPrimary,
      contentTextStyle: const TextStyle(color: AppPallete.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppPallete.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppPallete.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppPallete.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppPallete.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppPallete.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppPallete.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppPallete.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppPallete.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppPallete.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppPallete.textPrimary,
      ),
    ),
  );
}
