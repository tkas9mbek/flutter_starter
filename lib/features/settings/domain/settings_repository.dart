import 'package:starter/features/settings/data/settings_data_source.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';

class SettingsRepository {
  final SettingsDataSource _settingsDataSource;

  SettingsRepository(this._settingsDataSource);

  LanguageOption getLanguageOption() {
    final languageCode = _settingsDataSource.getLanguageCode();

    return LanguageOption.fromCode(languageCode);
  }

  Future<void> setLanguageOption(LanguageOption languageOption) async {
    await _settingsDataSource.setLanguageCode(languageOption.code);
  }

  String getLanguageCode() {
    final option = getLanguageOption();

    return option.code;
  }

  ThemeModeOption getThemeModeOption() {
    final themeMode = _settingsDataSource.getThemeMode();

    return ThemeModeOption.fromString(themeMode);
  }

  Future<void> setThemeModeOption(ThemeModeOption themeModeOption) async {
    await _settingsDataSource.setThemeMode(themeModeOption.toString());
  }
}
