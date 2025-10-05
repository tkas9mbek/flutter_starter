abstract class PreferencesDataSource {
  String? getLanguageCode();

  Future<void> setLanguageCode(String code);
}
