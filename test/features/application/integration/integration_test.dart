import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/application/environment/data/local_environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/bloc/environment_cubit.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

/// Integration tests: EnvironmentCubit → EnvironmentRepository → LocalEnvironmentDataSource → SharedPreferences (in-memory)
///
/// Tests the full flow from Cubit through Repository and DataSource using in-memory SharedPreferences.
/// FlutterSecureStorage is mocked as it's a native plugin.
void main() {
  late EnvironmentDataSource environmentDataSource;
  late EnvironmentRepository environmentRepository;
  late SharedPreferences sharedPreferences;
  late MockFlutterSecureStorage mockSecureStorage;
  OnEnvironmentChanged? onEnvironmentChanged;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    mockSecureStorage = MockFlutterSecureStorage();

    when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});

    environmentDataSource = LocalEnvironmentDataSource(
      sharedPreferences,
      mockSecureStorage,
    );
    environmentRepository = EnvironmentRepository(
      environmentDataSource,
      onEnvironmentChanged,
    );
  });

  group('EnvironmentCubit integration', () {
    late EnvironmentCubit environmentCubit;

    setUp(() {
      environmentCubit = EnvironmentCubit(environmentRepository);
    });

    test('initial state defaults to Mock when no saved preference', () {
      expect(environmentCubit.state, AppEnvironment.mock());
    });

    blocTest<EnvironmentCubit, AppEnvironment>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Dev)',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.dev()),
      expect: () => [AppEnvironment.dev()],
      verify: (_) {
        final savedEnv = sharedPreferences.getString('env_url_key');
        expect(savedEnv, 'dev');
      },
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Mock)',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.mock()),
      expect: () => [AppEnvironment.mock()],
      verify: (_) {
        final savedEnv = sharedPreferences.getString('env_url_key');
        expect(savedEnv, 'mock');
      },
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Production)',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.prod()),
      expect: () => [AppEnvironment.prod()],
      verify: (_) {
        final savedEnv = sharedPreferences.getString('env_url_key');
        expect(savedEnv, 'prod');
      },
    );

    test('loads saved environment preference from SharedPreferences', () async {
      await sharedPreferences.setString('env_url_key', 'dev');

      final cubit = EnvironmentCubit(environmentRepository);

      expect(cubit.state, AppEnvironment.dev());
    });

    blocTest<EnvironmentCubit, AppEnvironment>(
      'switches between environments multiple times',
      build: () => environmentCubit,
      act: (cubit) async {
        await cubit.setEnvironment(AppEnvironment.dev());
        await cubit.setEnvironment(AppEnvironment.prod());
        await cubit.setEnvironment(AppEnvironment.mock());
      },
      expect: () => [
        AppEnvironment.dev(),
        AppEnvironment.prod(),
        AppEnvironment.mock(),
      ],
      verify: (_) {
        final savedEnv = sharedPreferences.getString('env_url_key');
        expect(savedEnv, 'mock'); // Last value
      },
    );
  });

  group('EnvironmentCubit with onEnvironmentChanged callback', () {
    late EnvironmentCubit environmentCubit;
    var callbackInvoked = false;
    AppEnvironment? callbackEnvironment;

    setUp(() {
      callbackInvoked = false;
      callbackEnvironment = null;

      environmentRepository = EnvironmentRepository(
        environmentDataSource,
        (env) async {
          callbackInvoked = true;
          callbackEnvironment = env;
        },
      );
      environmentCubit = EnvironmentCubit(environmentRepository);
    });

    blocTest<EnvironmentCubit, AppEnvironment>(
      'invokes callback when environment changes',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.dev()),
      expect: () => [AppEnvironment.dev()],
      verify: (_) {
        expect(callbackInvoked, isTrue);
        expect(callbackEnvironment, AppEnvironment.dev());
      },
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'invokes callback for each environment change',
      build: () => environmentCubit,
      act: (cubit) async {
        await cubit.setEnvironment(AppEnvironment.prod());
        await cubit.setEnvironment(AppEnvironment.mock());
      },
      expect: () => [
        AppEnvironment.prod(),
        AppEnvironment.mock(),
      ],
      verify: (_) {
        expect(callbackInvoked, isTrue);
        expect(callbackEnvironment, AppEnvironment.mock()); // Last value
      },
    );
  });
}
