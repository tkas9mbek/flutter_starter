import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';

void main() {
  final theme = AppTheme.dark();
  final styles = AppTextStyles(theme);

  // (style, font size, line height in px, weight)
  final scale = <String, (TextStyle, double, double, FontWeight)>{
    'regularTitle28': (styles.regularTitle28, 28, 34, FontWeight.w400),
    'mediumTitle28': (styles.mediumTitle28, 28, 34, FontWeight.w500),
    'boldTitle28': (styles.boldTitle28, 28, 34, FontWeight.w700),
    'regularTitle24': (styles.regularTitle24, 24, 30, FontWeight.w400),
    'mediumTitle24': (styles.mediumTitle24, 24, 30, FontWeight.w500),
    'boldTitle24': (styles.boldTitle24, 24, 30, FontWeight.w700),
    'regularTitle20': (styles.regularTitle20, 20, 26, FontWeight.w400),
    'mediumTitle20': (styles.mediumTitle20, 20, 26, FontWeight.w500),
    'boldTitle20': (styles.boldTitle20, 20, 26, FontWeight.w700),
    'regularTitle18': (styles.regularTitle18, 18, 24, FontWeight.w400),
    'mediumTitle18': (styles.mediumTitle18, 18, 24, FontWeight.w500),
    'boldTitle18': (styles.boldTitle18, 18, 24, FontWeight.w700),
    'regularBody16': (styles.regularBody16, 16, 21, FontWeight.w400),
    'mediumBody16': (styles.mediumBody16, 16, 21, FontWeight.w500),
    'boldBody16': (styles.boldBody16, 16, 21, FontWeight.w700),
    'regularBody14': (styles.regularBody14, 14, 17, FontWeight.w400),
    'mediumBody14': (styles.mediumBody14, 14, 17, FontWeight.w500),
    'boldBody14': (styles.boldBody14, 14, 17, FontWeight.w700),
    'regularBody13': (styles.regularBody13, 13, 17, FontWeight.w400),
    'mediumBody13': (styles.mediumBody13, 13, 17, FontWeight.w500),
    'boldBody13': (styles.boldBody13, 13, 17, FontWeight.w700),
    'regularBody12': (styles.regularBody12, 12, 16, FontWeight.w400),
    'mediumBody12': (styles.mediumBody12, 12, 16, FontWeight.w500),
    'boldBody12': (styles.boldBody12, 12, 16, FontWeight.w700),
    'regularBody10': (styles.regularBody10, 10, 14, FontWeight.w400),
    'mediumBody10': (styles.mediumBody10, 10, 14, FontWeight.w500),
    'boldBody10': (styles.boldBody10, 10, 14, FontWeight.w700),
  };

  group(
    'AppTextStyles',
    () => scale.forEach(
      (name, spec) => test('$name has its size, weight and line height', () {
        final (style, fontSize, lineHeight, weight) = spec;

        expect(style.fontSize, fontSize);
        expect(style.fontWeight, weight);
        expect(style.height! * fontSize, closeTo(lineHeight, 0.001));
        expect(style.color, theme.textPrimary);
        expect(
          style.fontFamily,
          'packages/${UiConsts.package}/'
          '${FontFamily.sfuitext}',
        );
      }),
    ),
  );
}
