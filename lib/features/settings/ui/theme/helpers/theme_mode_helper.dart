import 'package:flutter/material.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter_uikit/theme/app_theme.dart';

/// Helper class for converting theme mode options to Flutter theme configurations.
class ThemeModeHelper {
  /// Converts [ThemeModeOption] to Flutter's [ThemeMode].
  static ThemeMode getThemeMode(ThemeModeOption option) => switch (option) {
        ThemeModeOption.light => ThemeMode.light,
        ThemeModeOption.dark => ThemeMode.dark,
        ThemeModeOption.system => ThemeMode.system,
      };

  /// Gets the appropriate [AppTheme] based on [ThemeModeOption] and system brightness.
  static AppTheme getCurrentTheme(
    ThemeModeOption option,
    Brightness systemBrightness,
  ) =>
      switch (option) {
        ThemeModeOption.light => AppTheme.light(),
        ThemeModeOption.dark => AppTheme.dark(),
        ThemeModeOption.system => systemBrightness == Brightness.dark
            ? AppTheme.dark()
            : AppTheme.light(),
      };
}
