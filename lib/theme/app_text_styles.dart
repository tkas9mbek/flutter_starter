import 'package:flutter/material.dart';
import 'package:flutter_starter/resources/resources.dart';
import 'package:flutter_starter/theme/app_theme.dart';

class AppTextStyles {
  final String fontFamily;

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  static TextStyle get _sfUiBase => TextStyle(
        fontFamily: FontFamily.sfuitext,
        color: AppTheme.light().onBackground,
        leadingDistribution: TextLeadingDistribution.even,
      );

  AppTextStyles()
      : fontFamily = FontFamily.sfuitext,
        titleLarge = _sfUiBase.copyWith(
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w400,
        ),
        titleMedium = _sfUiBase.copyWith(
          fontSize: 16,
          height: 24 / 16,
          letterSpacing: 0.15,
          fontWeight: FontWeight.w500,
        ),
        titleSmall = _sfUiBase.copyWith(
          fontSize: 14,
          height: 20 / 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
        labelLarge = _sfUiBase.copyWith(
          fontSize: 14,
          height: 20 / 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
        labelMedium = _sfUiBase.copyWith(
          fontSize: 12,
          height: 16 / 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
        labelSmall = _sfUiBase.copyWith(
          fontSize: 11,
          height: 16 / 11,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge = _sfUiBase.copyWith(
          fontSize: 16,
          height: 24 / 16,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium = _sfUiBase.copyWith(
          fontSize: 14,
          height: 20 / 14,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w400,
        ),
        bodySmall = _sfUiBase.copyWith(
          fontSize: 12,
          height: 16 / 12,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w400,
        );
}
