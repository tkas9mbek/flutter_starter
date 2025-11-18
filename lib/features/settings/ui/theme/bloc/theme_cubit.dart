import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';

class ThemeCubit extends Cubit<ThemeModeOption> {
  final SettingsRepository _settingsRepository;

  ThemeCubit(this._settingsRepository)
      : super(_settingsRepository.getThemeModeOption());

  void setThemeModeOption(ThemeModeOption themeModeOption) {
    _settingsRepository.setThemeModeOption(themeModeOption);

    emit(themeModeOption);
  }
}
