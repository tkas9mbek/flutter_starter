import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/application/environment/data/local_environment_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late LocalEnvironmentDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource = LocalEnvironmentDataSource(
      mockSharedPreferences,
      mockSecureStorage,
    );
  });

  group('saveEnvName', () {
    test('saves environment name to SharedPreferences', () async {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      await dataSource.saveEnvName('dev');

      verify(() => mockSharedPreferences.setString('env_url_key', 'dev'))
          .called(1);
    });
  });

  group('getEnvName', () {
    test('returns environment name from SharedPreferences', () {
      when(() => mockSharedPreferences.getString(any())).thenReturn('prod');

      final result = dataSource.getEnvName();

      expect(result, equals('prod'));
      verify(() => mockSharedPreferences.getString('env_url_key')).called(1);
    });

    test('returns null when no environment name is saved', () {
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      final result = dataSource.getEnvName();

      expect(result, isNull);
    });
  });

  group('clearSecureStorage', () {
    test('clears all secure storage', () async {
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async => {});

      await dataSource.clearSecureStorage();

      verify(() => mockSecureStorage.deleteAll()).called(1);
    });
  });
}
