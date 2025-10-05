import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';

class EnvironmentRepository {
  final EnvironmentDataSource _environmentDataSource;

  EnvironmentRepository(
    this._environmentDataSource,
  );

  Future<void> changeEnvironment(AppEnvironment env) async {
    await _environmentDataSource.saveEnvName(env.name);
    await _environmentDataSource.clearSecureStorage();
  }

  AppEnvironment getEnvironment() {
    final envName = _environmentDataSource.getEnvName();

    return AppEnvironment.fromName(envName);
  }
}
