import 'package:starter/features/auth/model/auth_token.dart';

abstract class AuthLocalDataSource {
  Future<void> clearStorage();

  Future<void> saveToken(AuthToken token);

  Future<void> clearIfNotLaunchedBefore();

  Future<AuthToken?> getToken();
}
