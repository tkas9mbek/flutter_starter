import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/features/settings/data/local_settings_data_source.dart';
import 'package:starter/features/settings/data/settings_data_source.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class _ThrowingSettingsDataSource implements SettingsDataSource {
  const _ThrowingSettingsDataSource();

  @override
  String? getLanguageCode() => throw const DevelopmentException();

  @override
  Future<void> setLanguageCode(String code) async =>
      throw const DevelopmentException();

  @override
  String? getThemeMode() => throw const DevelopmentException();

  @override
  Future<void> setThemeMode(String mode) async =>
      throw const DevelopmentException();
}

void main() {
  late SharedPreferences preferences;
  late SettingsRepository repository;

  SettingsRepository failingRepository() =>
      SettingsRepository(const _ThrowingSettingsDataSource());

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    repository = SettingsRepository(LocalSettingsDataSource(preferences));
  });

  group('theme flow', () {
    test('persists the selected theme end-to-end', () async {
      final cubit = ThemeCubit(repository);

      cubit.setThemeModeOption(ThemeModeOption.dark);
      await pumpEventQueue();

      expect(cubit.state, ThemeModeOption.dark);
      expect(preferences.getString(SharedPreferencesKeys.themeMode), 'dark');
    });

    test('restores the persisted theme on construction', () async {
      await preferences.setString(SharedPreferencesKeys.themeMode, 'light');

      expect(ThemeCubit(repository).state, ThemeModeOption.light);
    });
  });

  group('language flow', () {
    test('persists the selected language end-to-end', () async {
      final english = languageOptionsAvailable.firstWhere(
        (option) => option.code == 'en',
      );
      final cubit = LanguageCubit(repository);

      cubit.setLanguageOption(english);
      await pumpEventQueue();

      expect(cubit.state.code, 'en');
      expect(preferences.getString(SharedPreferencesKeys.languageCode), 'en');
    });

    test('restores the persisted language on construction', () async {
      await preferences.setString(SharedPreferencesKeys.languageCode, 'ru');

      expect(LanguageCubit(repository).state.code, 'ru');
    });
  });

  group('failure branch', () {
    test(
      'a failing read surfaces through cubit construction',
      () => expect(
        () => ThemeCubit(failingRepository()),
        throwsA(isA<DevelopmentException>()),
      ),
    );

    // The cubits fire writes with `unawaited`, so a write failure is only
    // observable on the repository future, not on the emitted state.
    test(
      'a failing write surfaces on the repository future',
      () => expect(
        failingRepository().setThemeModeOption(ThemeModeOption.dark),
        throwsA(isA<DevelopmentException>()),
      ),
    );
  });
}
