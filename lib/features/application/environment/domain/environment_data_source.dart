abstract class EnvironmentDataSource {
  Future<void> saveEnvName(String url);

  Future<void> clearSecureStorage();

  String? getEnvName();
}
