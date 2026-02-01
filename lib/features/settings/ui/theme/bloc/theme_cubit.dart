import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';

class ThemeCubit extends Cubit<ThemeModeOption> {
  ThemeCubit(this._settingsRepository)
    : super(_settingsRepository.getThemeModeOption());

  final SettingsRepository _settingsRepository;

  void setThemeModeOption(ThemeModeOption themeModeOption) {
    unawaited(_settingsRepository.setThemeModeOption(themeModeOption));

    emit(themeModeOption);
  }
}
