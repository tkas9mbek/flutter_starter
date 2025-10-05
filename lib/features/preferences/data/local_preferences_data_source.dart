import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/consts/storage_keys.dart';
import 'package:starter/features/preferences/data/preferences_data_source.dart';

class LocalPreferencesDataSource implements PreferencesDataSource {
  final SharedPreferences _sharedPreferences;

  LocalPreferencesDataSource(this._sharedPreferences);

  @override
  String? getLanguageCode() =>
      _sharedPreferences.getString(SharedPreferencesKeys.languageCode);

  @override
  Future<void> setLanguageCode(String code) => _sharedPreferences.setString(
        SharedPreferencesKeys.languageCode,
        code,
      );
}
