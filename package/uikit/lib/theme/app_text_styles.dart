import 'package:flutter/material.dart';
import 'package:uikit/resources/resources.dart';
import 'package:uikit/theme/app_theme.dart';

class AppTextStyles {
  final String fontFamily;

  /// [ Title styles - Medium (18-20) ]
  final TextStyle regularTitle20;
  final TextStyle mediumTitle20;
  final TextStyle boldTitle20;
  final TextStyle boldTitle18;
  final TextStyle mediumTitle18;
  final TextStyle regularTitle18;

  /// [ Body styles - Large (16) ]
  final TextStyle regularBody16;
  final TextStyle mediumBody16;
  final TextStyle boldBody16;

  /// [ Body styles - Medium (14) ]
  final TextStyle regularBody14;
  final TextStyle mediumBody14;
  final TextStyle boldBody14;

  /// [ Body styles - Small (13) ]
  final TextStyle regularBody13;
  final TextStyle mediumBody13;
  final TextStyle boldBody13;

  static TextStyle get _sfUiBase => TextStyle(
        fontFamily: FontFamily.sfuitext,
        color: AppTheme.light().textPrimary,
        leadingDistribution: TextLeadingDistribution.even,
      );

  AppTextStyles()
      : fontFamily = FontFamily.sfuitext,
        regularTitle20 = _sfUiBase.copyWith(
          fontSize: 20,
          height: 25 / 20,
          fontWeight: FontWeight.w400,
        ),
        mediumTitle20 = _sfUiBase.copyWith(
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w500,
        ),
        boldTitle20 = _sfUiBase.copyWith(
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w700,
        ),
        boldTitle18 = _sfUiBase.copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w700,
        ),
        mediumTitle18 = _sfUiBase.copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w500,
        ),
        regularTitle18 = _sfUiBase.copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w400,
        ),
        regularBody16 = _sfUiBase.copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w400,
        ),
        mediumBody16 = _sfUiBase.copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w500,
        ),
        boldBody16 = _sfUiBase.copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w700,
        ),
        regularBody14 = _sfUiBase.copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w400,
        ),
        mediumBody14 = _sfUiBase.copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w500,
        ),
        boldBody14 = _sfUiBase.copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w700,
        ),
        regularBody13 = _sfUiBase.copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w400,
        ),
        mediumBody13 = _sfUiBase.copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w500,
        ),
        boldBody13 = _sfUiBase.copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w700,
        );
}
