import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/bloc/environment_cubit.dart';

class MockEnvironmentLocalDataSource extends Mock implements EnvironmentDataSource {}

void main() {
  late MockEnvironmentLocalDataSource mockDataSource;
  late EnvironmentRepository realRepository;
  late EnvironmentCubit environmentCubit;
  late AppEnvironment prodEnv;
  late AppEnvironment devEnv;

  setUp(() {
    mockDataSource = MockEnvironmentLocalDataSource();
    realRepository = EnvironmentRepository(mockDataSource);

    prodEnv = AppEnvironment.prod();
    devEnv = AppEnvironment.dev();

    when(() => mockDataSource.getEnvName()).thenReturn(prodEnv.name);

    environmentCubit = EnvironmentCubit(realRepository);
  });

  tearDown(() {
    environmentCubit.close();
  });

  group('EnvironmentCubit', () {
    test('initial state is correctly read from the repository', () {
      expect(environmentCubit.state, prodEnv);
      verify(() => realRepository.getEnvironment()).called(1);
    });

    blocTest<EnvironmentCubit, AppEnvironment>(
      'emits the new environment when setEnvironment is called successfully',
      setUp: () {
        // We need to stub the methods that the repository will call on the data source
        when(() => mockDataSource.clearSecureStorage()).thenAnswer((_) async {});
        when(() => mockDataSource.saveEnvName(any())).thenAnswer((_) async {});
      },
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(devEnv),
      expect: () => <AppEnvironment>[devEnv],
      verify: (_) {
        verify(() => mockDataSource.clearSecureStorage()).called(1);
        verify(() => mockDataSource.saveEnvName(devEnv.name)).called(1);
      },
    );
  });
}
