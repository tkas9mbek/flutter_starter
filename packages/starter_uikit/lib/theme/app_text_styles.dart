import 'package:flutter/material.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/app_theme.dart';

class AppTextStyles {
  final String fontFamily;
  final AppTheme theme;

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

  /// [ Body styles - Extra Small (12) ]
  final TextStyle regularBody12;
  final TextStyle mediumBody12;
  final TextStyle boldBody12;

  /// [ Body styles - Tiny (10) ]
  final TextStyle regularBody10;
  final TextStyle mediumBody10;
  final TextStyle boldBody10;

  AppTextStyles(this.theme)
      : fontFamily = FontFamily.sfuitext,
        regularTitle20 = _sfUiBase(theme).copyWith(
          fontSize: 20,
          height: 25 / 20,
          fontWeight: FontWeight.w400,
        ),
        mediumTitle20 = _sfUiBase(theme).copyWith(
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w500,
        ),
        boldTitle20 = _sfUiBase(theme).copyWith(
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w700,
        ),
        boldTitle18 = _sfUiBase(theme).copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w700,
        ),
        mediumTitle18 = _sfUiBase(theme).copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w500,
        ),
        regularTitle18 = _sfUiBase(theme).copyWith(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w400,
        ),
        regularBody16 = _sfUiBase(theme).copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w400,
        ),
        mediumBody16 = _sfUiBase(theme).copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w500,
        ),
        boldBody16 = _sfUiBase(theme).copyWith(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w700,
        ),
        regularBody14 = _sfUiBase(theme).copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w400,
        ),
        mediumBody14 = _sfUiBase(theme).copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w500,
        ),
        boldBody14 = _sfUiBase(theme).copyWith(
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w700,
        ),
        regularBody13 = _sfUiBase(theme).copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w400,
        ),
        mediumBody13 = _sfUiBase(theme).copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w500,
        ),
        boldBody13 = _sfUiBase(theme).copyWith(
          fontSize: 13,
          height: 17 / 13,
          fontWeight: FontWeight.w700,
        ),
        regularBody12 = _sfUiBase(theme).copyWith(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
        ),
        mediumBody12 = _sfUiBase(theme).copyWith(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
        ),
        boldBody12 = _sfUiBase(theme).copyWith(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w700,
        ),
        regularBody10 = _sfUiBase(theme).copyWith(
          fontSize: 10,
          height: 14 / 10,
          fontWeight: FontWeight.w400,
        ),
        mediumBody10 = _sfUiBase(theme).copyWith(
          fontSize: 10,
          height: 14 / 10,
          fontWeight: FontWeight.w500,
        ),
        boldBody10 = _sfUiBase(theme).copyWith(
          fontSize: 10,
          height: 14 / 10,
          fontWeight: FontWeight.w700,
        );

  static TextStyle _sfUiBase(AppTheme theme) => TextStyle(
        package: UiConsts.package,
        fontFamily: FontFamily.sfuitext,
        color: theme.textPrimary,
        leadingDistribution: TextLeadingDistribution.even,
      );
}
