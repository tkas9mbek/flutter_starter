import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late ThemeCubit themeCubit;
  late MockSettingsRepository mockRepository;

  setUp(() {
    mockRepository = MockSettingsRepository();
    when(() => mockRepository.getThemeModeOption())
        .thenReturn(ThemeModeOption.system);
    themeCubit = ThemeCubit(mockRepository);
  });

  test('initial state is from repository', () {
    expect(themeCubit.state, equals(ThemeModeOption.system));
  });

  blocTest<ThemeCubit, ThemeModeOption>(
    'emits new theme mode when setThemeModeOption is called',
    build: () {
      when(() => mockRepository.setThemeModeOption(ThemeModeOption.light))
          .thenAnswer((_) async => {});
      return themeCubit;
    },
    act: (cubit) => cubit.setThemeModeOption(ThemeModeOption.light),
    expect: () => [ThemeModeOption.light],
    verify: (_) {
      verify(() => mockRepository.setThemeModeOption(ThemeModeOption.light))
          .called(1);
    },
  );
}
