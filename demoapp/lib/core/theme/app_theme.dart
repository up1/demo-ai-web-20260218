import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application color constants derived from the Figma design.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF8383);
  static const Color background = Color(0xFFFFFCFC);
  static const Color textDark = Color(0xFF424242);
  static const Color textMedium = Color(0xFF616161);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color white = Color(0xFFF8F8FF);
  static const Color divider = Color(0xFFBDBDBD);
}

/// Builds the light [ThemeData] for the application, using Rubik
/// font and the coral-pink color palette from the Figma designs.
ThemeData buildLightTheme() {
  final textTheme = GoogleFonts.rubikTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.background,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
        height: 1.1,
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontSize: 38,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
        height: 1.1,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.4,
        letterSpacing: 0.2,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textMedium,
        height: 1.4,
        letterSpacing: 0.2,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textMedium,
        height: 1.4,
        letterSpacing: 0.2,
      ),
      bodySmall: textTheme.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
        letterSpacing: 0.2,
      ),
      labelSmall: textTheme.labelSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
        height: 1.4,
        letterSpacing: 0.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        textStyle: GoogleFonts.rubik(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          height: 1.4,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.divider),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.divider),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      labelStyle: GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textMedium,
        letterSpacing: 0.2,
      ),
      hintStyle: GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        letterSpacing: 0.2,
      ),
    ),
  );
}
