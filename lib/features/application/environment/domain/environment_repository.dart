import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';

typedef OnEnvironmentChanged = Future<void> Function(AppEnvironment);

class EnvironmentRepository {
  final EnvironmentDataSource _environmentDataSource;
  final OnEnvironmentChanged? _onEnvironmentChanged;

  const EnvironmentRepository(
    this._environmentDataSource,
    this._onEnvironmentChanged,
  );

  Future<void> changeEnvironment(AppEnvironment env) async {
    await _environmentDataSource.saveEnvName(env.name);
    await _environmentDataSource.clearSecureStorage();

    if (_onEnvironmentChanged != null) {
      await _onEnvironmentChanged!(env);
    }
  }

  AppEnvironment getEnvironment() {
    final envName = _environmentDataSource.getEnvName();

    return AppEnvironment.fromName(envName);
  }
}
