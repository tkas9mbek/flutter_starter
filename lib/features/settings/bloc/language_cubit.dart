import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';

class LanguageCubit extends Cubit<LanguageOption> {
  final SettingsRepository _settingsRepository;

  LanguageCubit(this._settingsRepository)
      : super(_settingsRepository.getLanguageOption());

  void setLanguageOption(LanguageOption languageOption) {
    _settingsRepository.setLanguageOption(languageOption);

    emit(languageOption);
  }
}
