import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';

class LanguageCubit extends Cubit<LanguageOption> {
  LanguageCubit(this._settingsRepository)
    : super(_settingsRepository.getLanguageOption());

  final SettingsRepository _settingsRepository;

  void setLanguageOption(LanguageOption languageOption) {
    unawaited(_settingsRepository.setLanguageOption(languageOption));

    emit(languageOption);
  }
}
