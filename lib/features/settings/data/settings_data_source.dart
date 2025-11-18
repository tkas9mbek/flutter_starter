abstract class SettingsDataSource {
  String? getLanguageCode();

  Future<void> setLanguageCode(String code);

  String? getThemeMode();

  Future<void> setThemeMode(String mode);
}
