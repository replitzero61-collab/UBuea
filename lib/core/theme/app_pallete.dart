import 'package:flutter/material.dart';

class AppPallete {
  static const Color primarySkyBlue = Color(0xFF00B4D8);
  static const Color darkSkyBlue = Color(0xFF0096C7);
  static const Color lightSkyBlue = Color(0xFF90E0EF);
  static const Color paleBlue = Color(0xFFCAF0F8);
  
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFEF5350);
  static const Color successColor = Color(0xFF66BB6A);
  static const Color warningColor = Color(0xFFFFA726);
  
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFFEEEEEE);
  
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [primarySkyBlue, darkSkyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient lightGradient = LinearGradient(
    colors: [lightSkyBlue, paleBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
