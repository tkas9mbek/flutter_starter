import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/settings/data/settings_data_source.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';

class MockSettingsDataSource extends Mock implements SettingsDataSource {}

void main() {
  late SettingsRepository repository;
  late MockSettingsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSettingsDataSource();
    repository = SettingsRepository(mockDataSource);
  });

  group('getLanguageOption', () {
    test('returns language option from data source', () {
      when(() => mockDataSource.getLanguageCode()).thenReturn('en');

      final result = repository.getLanguageOption();

      expect(result.code, equals('en'));
      verify(() => mockDataSource.getLanguageCode()).called(1);
    });
  });

  group('setLanguageOption', () {
    test('saves language code via data source', () async {
      when(() => mockDataSource.setLanguageCode('ru'))
          .thenAnswer((_) async => {});

      await repository.setLanguageOption(LanguageOption.fromCode('ru'));

      verify(() => mockDataSource.setLanguageCode('ru')).called(1);
    });
  });

  group('getLanguageCode', () {
    test('returns language code from language option', () {
      when(() => mockDataSource.getLanguageCode()).thenReturn('ru');

      final result = repository.getLanguageCode();

      expect(result, equals('ru'));
      verify(() => mockDataSource.getLanguageCode()).called(1);
    });
  });

  group('getThemeModeOption', () {
    test('returns theme mode option from data source', () {
      when(() => mockDataSource.getThemeMode()).thenReturn('light');

      final result = repository.getThemeModeOption();

      expect(result, equals(ThemeModeOption.light));
    });
  });

  group('setThemeModeOption', () {
    test('saves theme mode via data source', () async {
      when(() => mockDataSource.setThemeMode(any()))
          .thenAnswer((_) async => {});

      await repository.setThemeModeOption(ThemeModeOption.dark);

      verify(() => mockDataSource.setThemeMode(any())).called(1);
    });
  });
}
