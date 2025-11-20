import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';

class MockEnvironmentDataSource extends Mock implements EnvironmentDataSource {}

void main() {
  late EnvironmentRepository repository;
  late MockEnvironmentDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockEnvironmentDataSource();
    repository = EnvironmentRepository(mockDataSource, null);
  });

  group('getEnvironment', () {
    test('returns dev environment when data source returns "dev"', () {
      when(() => mockDataSource.getEnvName()).thenReturn('dev');

      final result = repository.getEnvironment();

      expect(result, equals(AppEnvironment.dev()));
      verify(() => mockDataSource.getEnvName()).called(1);
    });

    test('returns prod environment when data source returns "prod"', () {
      when(() => mockDataSource.getEnvName()).thenReturn('prod');

      final result = repository.getEnvironment();

      expect(result, equals(AppEnvironment.prod()));
    });

    test('returns mock environment when data source returns null', () {
      when(() => mockDataSource.getEnvName()).thenReturn(null);

      final result = repository.getEnvironment();

      expect(result, equals(AppEnvironment.mock()));
    });

    test('returns mock environment when data source returns unknown name', () {
      when(() => mockDataSource.getEnvName()).thenReturn('unknown');

      final result = repository.getEnvironment();

      expect(result, equals(AppEnvironment.mock()));
    });
  });

  group('changeEnvironment', () {
    test('saves environment name and clears secure storage', () async {
      final env = AppEnvironment.dev();

      when(() => mockDataSource.saveEnvName(any()))
          .thenAnswer((_) async => {});
      when(() => mockDataSource.clearSecureStorage())
          .thenAnswer((_) async => {});

      await repository.changeEnvironment(env);

      verify(() => mockDataSource.saveEnvName('dev')).called(1);
      verify(() => mockDataSource.clearSecureStorage()).called(1);
    });

    test('calls onEnvironmentChanged callback when provided', () async {
      var callbackCalled = false;
      AppEnvironment? callbackEnv;

      Future<void> onChanged(AppEnvironment env) async {
        callbackCalled = true;
        callbackEnv = env;
      }

      final repositoryWithCallback = EnvironmentRepository(
        mockDataSource,
        onChanged,
      );

      final env = AppEnvironment.prod();

      when(() => mockDataSource.saveEnvName(any()))
          .thenAnswer((_) async => {});
      when(() => mockDataSource.clearSecureStorage())
          .thenAnswer((_) async => {});

      await repositoryWithCallback.changeEnvironment(env);

      expect(callbackCalled, isTrue);
      expect(callbackEnv, equals(env));
    });

    test('does not fail when onEnvironmentChanged is null', () async {
      final env = AppEnvironment.mock();

      when(() => mockDataSource.saveEnvName(any()))
          .thenAnswer((_) async => {});
      when(() => mockDataSource.clearSecureStorage())
          .thenAnswer((_) async => {});

      await expectLater(
        repository.changeEnvironment(env),
        completes,
      );
    });
  });
}
