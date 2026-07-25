import 'package:starter/features/auth/model/auth_token.dart';

abstract class AuthLocalDataSource {
  Future<void> clearStorage();

  Future<void> saveToken(AuthToken token);

  /// Clears secure storage on first launch. Returns whether the app
  /// had been launched before.
  Future<bool> clearIfNotLaunchedBefore();

  Future<AuthToken?> getToken();
}
