import 'package:flutter/material.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/app_theme.dart';

/// Type scale rendered in [FontFamily.sfuitext]; `height` is the
/// line-height / font-size ratio. Colors default to `theme.textPrimary`.
class AppTextStyles {
  AppTextStyles(this.theme)
    : fontFamily = FontFamily.sfuitext,
      regularTitle28 = _style(theme, 28, 34, FontWeight.w400),
      mediumTitle28 = _style(theme, 28, 34, FontWeight.w500),
      boldTitle28 = _style(theme, 28, 34, FontWeight.w700),
      regularTitle24 = _style(theme, 24, 30, FontWeight.w400),
      mediumTitle24 = _style(theme, 24, 30, FontWeight.w500),
      boldTitle24 = _style(theme, 24, 30, FontWeight.w700),
      regularTitle20 = _style(theme, 20, 26, FontWeight.w400),
      mediumTitle20 = _style(theme, 20, 26, FontWeight.w500),
      boldTitle20 = _style(theme, 20, 26, FontWeight.w700),
      regularTitle18 = _style(theme, 18, 24, FontWeight.w400),
      mediumTitle18 = _style(theme, 18, 24, FontWeight.w500),
      boldTitle18 = _style(theme, 18, 24, FontWeight.w700),
      regularBody16 = _style(theme, 16, 21, FontWeight.w400),
      mediumBody16 = _style(theme, 16, 21, FontWeight.w500),
      boldBody16 = _style(theme, 16, 21, FontWeight.w700),
      regularBody14 = _style(theme, 14, 17, FontWeight.w400),
      mediumBody14 = _style(theme, 14, 17, FontWeight.w500),
      boldBody14 = _style(theme, 14, 17, FontWeight.w700),
      regularBody13 = _style(theme, 13, 17, FontWeight.w400),
      mediumBody13 = _style(theme, 13, 17, FontWeight.w500),
      boldBody13 = _style(theme, 13, 17, FontWeight.w700),
      regularBody12 = _style(theme, 12, 16, FontWeight.w400),
      mediumBody12 = _style(theme, 12, 16, FontWeight.w500),
      boldBody12 = _style(theme, 12, 16, FontWeight.w700),
      regularBody10 = _style(theme, 10, 14, FontWeight.w400),
      mediumBody10 = _style(theme, 10, 14, FontWeight.w500),
      boldBody10 = _style(theme, 10, 14, FontWeight.w700);

  final String fontFamily;
  final AppTheme theme;

  /// [ Title - Extra Large (28) ]
  final TextStyle regularTitle28;
  final TextStyle mediumTitle28;
  final TextStyle boldTitle28;

  /// [ Title - Large (24) ]
  final TextStyle regularTitle24;
  final TextStyle mediumTitle24;
  final TextStyle boldTitle24;

  /// [ Title - Medium (20) ]
  final TextStyle regularTitle20;
  final TextStyle mediumTitle20;
  final TextStyle boldTitle20;

  /// [ Title - Medium (18) ]
  final TextStyle regularTitle18;
  final TextStyle mediumTitle18;
  final TextStyle boldTitle18;

  /// [ Body - Large (16) ]
  final TextStyle regularBody16;
  final TextStyle mediumBody16;
  final TextStyle boldBody16;

  /// [ Body - Medium (14) ]
  final TextStyle regularBody14;
  final TextStyle mediumBody14;
  final TextStyle boldBody14;

  /// [ Body - Small (13) ]
  final TextStyle regularBody13;
  final TextStyle mediumBody13;
  final TextStyle boldBody13;

  /// [ Body - Extra Small (12) ]
  final TextStyle regularBody12;
  final TextStyle mediumBody12;
  final TextStyle boldBody12;

  /// [ Body - Tiny (10) ]
  final TextStyle regularBody10;
  final TextStyle mediumBody10;
  final TextStyle boldBody10;

  static TextStyle _style(
    AppTheme theme,
    double fontSize,
    double lineHeight,
    FontWeight fontWeight,
  ) => TextStyle(
    package: UiConsts.package,
    fontFamily: FontFamily.sfuitext,
    color: theme.textPrimary,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: fontSize,
    height: lineHeight / fontSize,
    fontWeight: fontWeight,
  );
}
