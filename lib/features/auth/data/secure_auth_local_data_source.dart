import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/consts/storage_keys.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/model/auth_token.dart';

class SecureAuthLocalDataSource implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  const SecureAuthLocalDataSource(
    this._secureStorage,
    this._sharedPreferences,
  );

  @override
  Future<void> clearStorage() => _secureStorage.deleteAll();

  @override
  Future<void> saveToken(AuthToken token) async {
    await _secureStorage.write(
      key: SecureStorageKeys.jwtTokenKey,
      value: token.accessToken,
    );
    await _secureStorage.write(
      key: SecureStorageKeys.refreshToken,
      value: token.refreshToken,
    );
  }

  @override
  Future<void> clearIfNotLaunchedBefore() async {
    final launchedBefore =
        _sharedPreferences.getBool(SharedPreferencesKeys.launchedBefore) ??
            false;

    if (!launchedBefore) {
      await _sharedPreferences.setBool(
        SharedPreferencesKeys.launchedBefore,
        true,
      );
      await _secureStorage.deleteAll();
    }
  }

  @override
  Future<AuthToken?> getToken() async {
    final accessToken =
        await _secureStorage.read(key: SecureStorageKeys.jwtTokenKey);
    final refreshToken =
        await _secureStorage.read(key: SecureStorageKeys.refreshToken);

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return AuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
