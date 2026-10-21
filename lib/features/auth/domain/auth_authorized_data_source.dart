import 'package:starter/features/auth/model/auth_token.dart';

abstract class AuthAuthorizedDataSource {
  /// Revokes [token] on the server. The token is passed in because local
  /// storage is already cleared by the time the request is sent.
  Future<void> logout(AuthToken token);
}
