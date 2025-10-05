import 'package:starter/features/preferences/data/preferences_data_source.dart';
import 'package:starter/features/preferences/model/language_option.dart';

class PreferencesRepository {
  final PreferencesDataSource _preferencesDataSource;

  PreferencesRepository(
    this._preferencesDataSource,
  );

  LanguageOption getLanguageOption() {
    final languageCode = _preferencesDataSource.getLanguageCode();

    return LanguageOption.fromCode(languageCode);
  }

  Future<void> setLanguageOption(LanguageOption languageOption) async {
    await _preferencesDataSource.setLanguageCode(languageOption.code);
  }

  String getLanguageCode() {
    final option = getLanguageOption();

    return option.code;
  }
}
