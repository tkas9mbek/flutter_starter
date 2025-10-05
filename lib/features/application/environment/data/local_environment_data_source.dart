import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';

const _envUrlKey = 'env_url_key';

class LocalEnvironmentDataSource implements EnvironmentDataSource {
  LocalEnvironmentDataSource(
    this._sharedPreferences,
    this._flutterSecureStorage,
  );

  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _flutterSecureStorage;

  @override
  Future<void> saveEnvName(String url) async {
    await _sharedPreferences.setString(_envUrlKey, url);
  }

  @override
  String? getEnvName() {
    return _sharedPreferences.getString(_envUrlKey);
  }

  @override
  Future<void> clearSecureStorage() async {
    await _flutterSecureStorage.deleteAll();
  }
}
