import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/features/auth/data/secure_auth_local_data_source.dart';

import '../model/auth_mock_models.dart';

void main() {
  late Map<String, String> keychain;

  // The plugin keeps a reference to this map, so tests can inspect the keychain.
  setUp(() {
    keychain = {};
    FlutterSecureStorage.setMockInitialValues(keychain);
  });

  Future<SecureAuthLocalDataSource> buildDataSource({
    bool launchedBefore = true,
  }) async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKeys.launchedBefore: launchedBefore,
    });

    return SecureAuthLocalDataSource(
      const FlutterSecureStorage(),
      await SharedPreferences.getInstance(),
    );
  }

  group('saveToken / getToken', () {
    test('reads back the token that was saved', () async {
      final dataSource = await buildDataSource();

      await dataSource.saveToken(AuthMockModels.authToken);

      expect(await dataSource.getToken(), AuthMockModels.authToken);
      expect(
        keychain[SecureStorageKeys.jwtTokenKey],
        AuthMockModels.authToken.accessToken,
      );
      expect(
        keychain[SecureStorageKeys.refreshToken],
        AuthMockModels.authToken.refreshToken,
      );
    });

    test('returns null when nothing is stored', () async {
      final dataSource = await buildDataSource();

      expect(await dataSource.getToken(), isNull);
    });

    test('returns null when only the access token is stored', () async {
      final dataSource = await buildDataSource();
      keychain[SecureStorageKeys.jwtTokenKey] = 'access';

      expect(await dataSource.getToken(), isNull);
    });
  });

  test('clearStorage removes the stored token', () async {
    final dataSource = await buildDataSource();
    await dataSource.saveToken(AuthMockModels.authToken);

    await dataSource.clearStorage();

    expect(await dataSource.getToken(), isNull);
  });

  group('clearIfNotLaunchedBefore', () {
    test('on first launch wipes leftovers and remembers the launch', () async {
      final dataSource = await buildDataSource(launchedBefore: false);
      await dataSource.saveToken(AuthMockModels.authToken);

      expect(await dataSource.clearIfNotLaunchedBefore(), isFalse);
      expect(await dataSource.getToken(), isNull);
      expect(await dataSource.clearIfNotLaunchedBefore(), isTrue);
    });

    test('on a later launch keeps the stored token', () async {
      final dataSource = await buildDataSource();
      await dataSource.saveToken(AuthMockModels.authToken);

      expect(await dataSource.clearIfNotLaunchedBefore(), isTrue);
      expect(await dataSource.getToken(), AuthMockModels.authToken);
    });
  });
}
