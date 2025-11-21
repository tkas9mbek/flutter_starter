import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/settings/data/local_settings_data_source.dart';
import 'package:starter/features/settings/data/settings_data_source.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';

/// Integration tests: Cubit → SettingsRepository → LocalSettingsDataSource → SharedPreferences (in-memory)
///
/// Tests the full flow from Cubit through Repository and DataSource using in-memory SharedPreferences.
void main() {
  late SettingsDataSource settingsDataSource;
  late SettingsRepository settingsRepository;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    settingsDataSource = LocalSettingsDataSource(sharedPreferences);
    settingsRepository = SettingsRepository(settingsDataSource);
  });

  group('LanguageCubit integration', () {
    late LanguageCubit languageCubit;

    setUp(() {
      languageCubit = LanguageCubit(settingsRepository);
    });

    test('initial state is defaultLanguageOption when no saved preference', () {
      expect(languageCubit.state, defaultLanguageOption);
    });

    blocTest<LanguageCubit, LanguageOption>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (English)',
      build: () => languageCubit,
      act: (cubit) => cubit.setLanguageOption(languageOptionsAvailable[1]),
      expect: () => [languageOptionsAvailable[1]],
      verify: (_) {
        final savedCode = sharedPreferences.getString('language_code');
        expect(savedCode, 'en');
      },
    );

    blocTest<LanguageCubit, LanguageOption>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Russian)',
      build: () => languageCubit,
      act: (cubit) => cubit.setLanguageOption(languageOptionsAvailable[0]),
      expect: () => [languageOptionsAvailable[0]],
      verify: (_) {
        final savedCode = sharedPreferences.getString('language_code');
        expect(savedCode, 'ru');
      },
    );

    test('loads saved language preference from SharedPreferences', () async {
      await sharedPreferences.setString('language_code', 'ru');

      final cubit = LanguageCubit(settingsRepository);

      expect(cubit.state, languageOptionsAvailable[0]);
    });

    blocTest<LanguageCubit, LanguageOption>(
      'switches between languages multiple times',
      build: () => languageCubit,
      act: (cubit) {
        cubit
          ..setLanguageOption(languageOptionsAvailable[0])
          ..setLanguageOption(languageOptionsAvailable[1])
          ..setLanguageOption(languageOptionsAvailable[0]);
      },
      expect: () => [
        languageOptionsAvailable[0],
        languageOptionsAvailable[1],
        languageOptionsAvailable[0],
      ],
      verify: (_) {
        final savedCode = sharedPreferences.getString('language_code');
        expect(savedCode, 'ru'); // Last value
      },
    );
  });

  group('ThemeCubit integration', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit(settingsRepository);
    });

    test('initial state defaults to System when no saved preference', () {
      expect(themeCubit.state, ThemeModeOption.system);
    });

    blocTest<ThemeCubit, ThemeModeOption>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Light)',
      build: () => themeCubit,
      act: (cubit) => cubit.setThemeModeOption(ThemeModeOption.light),
      expect: () => [ThemeModeOption.light],
      verify: (_) {
        final savedMode = sharedPreferences.getString('theme_mode');
        expect(savedMode, 'light');
      },
    );

    blocTest<ThemeCubit, ThemeModeOption>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Dark)',
      build: () => themeCubit,
      act: (cubit) => cubit.setThemeModeOption(ThemeModeOption.dark),
      expect: () => [ThemeModeOption.dark],
      verify: (_) {
        final savedMode = sharedPreferences.getString('theme_mode');
        expect(savedMode, 'dark');
      },
    );

    blocTest<ThemeCubit, ThemeModeOption>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (System)',
      build: () => themeCubit,
      act: (cubit) => cubit.setThemeModeOption(ThemeModeOption.system),
      expect: () => [ThemeModeOption.system],
      verify: (_) {
        final savedMode = sharedPreferences.getString('theme_mode');
        expect(savedMode, 'system');
      },
    );

    test('loads saved theme preference from SharedPreferences', () async {
      await sharedPreferences.setString('theme_mode', 'dark');

      final cubit = ThemeCubit(settingsRepository);

      expect(cubit.state, ThemeModeOption.dark);
    });

    blocTest<ThemeCubit, ThemeModeOption>(
      'switches between themes multiple times',
      build: () => themeCubit,
      act: (cubit) {
        cubit
          ..setThemeModeOption(ThemeModeOption.dark)
          ..setThemeModeOption(ThemeModeOption.light)
          ..setThemeModeOption(ThemeModeOption.system)
          ..setThemeModeOption(ThemeModeOption.dark);
      },
      expect: () => [
        ThemeModeOption.dark,
        ThemeModeOption.light,
        ThemeModeOption.system,
        ThemeModeOption.dark,
      ],
      verify: (_) {
        final savedMode = sharedPreferences.getString('theme_mode');
        expect(savedMode, 'dark'); // Last value
      },
    );
  });

  group('Combined Settings integration', () {
    test('language and theme preferences are independent', () async {
      await sharedPreferences.setString('language_code', 'ru');
      await sharedPreferences.setString('theme_mode', 'dark');

      final languageCubit = LanguageCubit(settingsRepository);
      final themeCubit = ThemeCubit(settingsRepository);

      expect(languageCubit.state, languageOptionsAvailable[0]);
      expect(themeCubit.state, ThemeModeOption.dark);

      languageCubit.setLanguageOption(languageOptionsAvailable[1]);
      await Future.delayed(const Duration(milliseconds: 10));

      // Theme should remain unchanged
      expect(themeCubit.state, ThemeModeOption.dark);
      expect(sharedPreferences.getString('theme_mode'), 'dark');
    });
  });
}
