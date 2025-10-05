import 'package:starter/features/auth/model/user.dart';

abstract class AuthAuthorizedDataSource {
  Future<User> getUserProfile();

  Future<void> logout();
}
