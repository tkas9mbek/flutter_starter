import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/theme/helpers/theme_mode_helper.dart';

void main() {
  const themeModes = <ThemeModeOption, ThemeMode>{
    ThemeModeOption.light: ThemeMode.light,
    ThemeModeOption.dark: ThemeMode.dark,
    ThemeModeOption.system: ThemeMode.system,
  };

  themeModes.forEach(
    (option, expected) => test(
      'getThemeMode maps $option to $expected',
      () => expect(ThemeModeHelper.getThemeMode(option), expected),
    ),
  );

  const currentThemes = <(ThemeModeOption, Brightness), ThemeMode>{
    (ThemeModeOption.light, Brightness.dark): ThemeMode.light,
    (ThemeModeOption.dark, Brightness.light): ThemeMode.dark,
    (ThemeModeOption.system, Brightness.light): ThemeMode.light,
    (ThemeModeOption.system, Brightness.dark): ThemeMode.dark,
  };

  currentThemes.forEach(
    (input, expected) => test(
      'getCurrentTheme for ${input.$1} under ${input.$2} is $expected',
      () => expect(
        ThemeModeHelper.getCurrentTheme(input.$1, input.$2).themeMode,
        expected,
      ),
    ),
  );
}
