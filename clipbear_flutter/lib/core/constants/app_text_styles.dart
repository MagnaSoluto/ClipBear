import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Text Style Constants
class AppTextStyles {
  AppTextStyles._();

  // Base Text Style (Inter font)
  static TextStyle get _baseTextStyle => GoogleFonts.inter();

  // Display Styles
  static TextStyle displayLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
        color: color,
      );

  static TextStyle displayMedium({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        height: 1.2,
        color: color,
      );

  static TextStyle displaySmall({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: color,
      );

  // Headline Styles
  static TextStyle headlineLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle headlineMedium({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      );

  static TextStyle headlineSmall({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      );

  // Title Styles
  static TextStyle titleLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: color,
      );

  static TextStyle titleMedium({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  static TextStyle titleSmall({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  // Body Styles
  static TextStyle bodyLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: color,
      );

  static TextStyle bodyMedium({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: color,
      );

  static TextStyle bodySmall({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: color,
      );

  // Label Styles
  static TextStyle labelLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: color,
      );

  static TextStyle labelMedium({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: color,
      );

  static TextStyle labelSmall({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: color,
      );

  // Caption/Overline
  static TextStyle caption({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
        color: color,
      );

  static TextStyle overline({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        height: 1.6,
        color: color,
      );

  // Button Styles
  static TextStyle button({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        height: 1.4,
        color: color,
      );

  static TextStyle buttonLarge({Color? color}) => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        height: 1.4,
        color: color,
      );
}
