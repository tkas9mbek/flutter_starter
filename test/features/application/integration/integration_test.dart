import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/application/environment/data/local_environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

/// Failure-branch double: writes throw, reads succeed so the cubit is still constructible
/// (`EnvironmentCubit` reads the environment in its initializer).
class _ThrowingEnvironmentDataSource implements EnvironmentDataSource {
  @override
  String? getEnvName() => null;

  @override
  Future<void> saveEnvName(String url) async =>
      throw const DevelopmentException();

  @override
  Future<void> clearSecureStorage() async => throw const DevelopmentException();
}

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

    setUp(() => environmentCubit = EnvironmentCubit(environmentRepository));

    test(
      'initial state defaults to Mock when no saved preference',
      () => expect(environmentCubit.state, AppEnvironment.mock()),
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Dev)',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.dev()),
      expect: () => [AppEnvironment.dev()],
      verify: (_) {
        expect(sharedPreferences.getString('env_url_key'), 'dev');
        verify(() => mockSecureStorage.deleteAll()).called(1);
      },
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'does nothing when selecting the current environment',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.mock()),
      expect: () => <AppEnvironment>[],
      verify: (_) {
        final savedEnv = sharedPreferences.getString('env_url_key');
        expect(savedEnv, isNull);
        verifyNever(() => mockSecureStorage.deleteAll());
      },
    );

    blocTest<EnvironmentCubit, AppEnvironment>(
      'completes full flow: Cubit → Repository → DataSource → SharedPreferences (Production)',
      build: () => environmentCubit,
      act: (cubit) => cubit.setEnvironment(AppEnvironment.prod()),
      expect: () => [AppEnvironment.prod()],
      verify: (_) => expect(sharedPreferences.getString('env_url_key'), 'prod'),
    );

    test('loads saved environment preference from SharedPreferences', () async {
      await sharedPreferences.setString('env_url_key', 'dev');

      final cubit = EnvironmentCubit(environmentRepository);

      expect(cubit.state, AppEnvironment.dev());
    });

    test('falls back to Mock when the stored name is unrecognised', () async {
      await sharedPreferences.setString('env_url_key', 'unknown');

      final cubit = EnvironmentCubit(environmentRepository);

      expect(cubit.state, AppEnvironment.mock());
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

      environmentRepository = EnvironmentRepository(environmentDataSource, (
        env,
      ) async {
        callbackInvoked = true;
        callbackEnvironment = env;
      });
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
      expect: () => [AppEnvironment.prod(), AppEnvironment.mock()],
      verify: (_) {
        expect(callbackInvoked, isTrue);
        expect(callbackEnvironment, AppEnvironment.mock()); // Last value
      },
    );
  });

  group('EnvironmentCubit failure branch', () {
    late EnvironmentCubit environmentCubit;
    var callbackInvoked = false;

    setUp(() {
      callbackInvoked = false;
      environmentCubit = EnvironmentCubit(
        EnvironmentRepository(_ThrowingEnvironmentDataSource(), (_) async {
          callbackInvoked = true;
        }),
      );
    });

    test('surfaces a data-source failure end-to-end', () async {
      await expectLater(
        environmentCubit.setEnvironment(AppEnvironment.dev()),
        throwsA(isA<DevelopmentException>()),
      );
    });

    test(
      'does not emit or notify when persisting the environment fails',
      () async {
        await expectLater(
          environmentCubit.setEnvironment(AppEnvironment.dev()),
          throwsA(isA<DevelopmentException>()),
        );

        expect(environmentCubit.state, AppEnvironment.mock());
        expect(callbackInvoked, isFalse);
      },
    );
  });
}
