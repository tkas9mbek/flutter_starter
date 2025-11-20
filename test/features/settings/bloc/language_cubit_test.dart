import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late LanguageCubit languageCubit;
  late MockSettingsRepository mockRepository;

  setUp(() {
    mockRepository = MockSettingsRepository();
    final russianOption = LanguageOption.fromCode('ru');
    when(() => mockRepository.getLanguageOption()).thenReturn(russianOption);
    languageCubit = LanguageCubit(mockRepository);
  });

  test('initial state is from repository', () {
    final russianOption = LanguageOption.fromCode('ru');
    expect(languageCubit.state.code, equals(russianOption.code));
  });

  blocTest<LanguageCubit, LanguageOption>(
    'emits new language when setLanguageOption is called',
    build: () {
      final englishOption = LanguageOption.fromCode('en');
      when(() => mockRepository.setLanguageOption(englishOption))
          .thenAnswer((_) async => {});
      return languageCubit;
    },
    act: (cubit) {
      final englishOption = LanguageOption.fromCode('en');
      cubit.setLanguageOption(englishOption);
    },
    expect: () {
      final englishOption = LanguageOption.fromCode('en');
      return [englishOption];
    },
    verify: (_) {
      final englishOption = LanguageOption.fromCode('en');
      verify(() => mockRepository.setLanguageOption(englishOption)).called(1);
    },
  );
}
