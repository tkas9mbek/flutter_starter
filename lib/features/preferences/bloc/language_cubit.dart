import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/preferences/model/language_option.dart';
import 'package:starter/features/preferences/repository/preferences_repository.dart';

class LanguageCubit extends Cubit<LanguageOption> {
  final PreferencesRepository _preferencesRepository;

  LanguageCubit(
    this._preferencesRepository,
  ) : super(_preferencesRepository.getLanguageOption());

  void setLanguageOption(LanguageOption languageOption) {
    _preferencesRepository.setLanguageOption(languageOption);

    emit(languageOption);
  }
}
