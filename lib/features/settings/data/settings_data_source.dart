abstract class SettingsDataSource {
  String? getLanguageCode();

  Future<void> setLanguageCode(String code);
}
