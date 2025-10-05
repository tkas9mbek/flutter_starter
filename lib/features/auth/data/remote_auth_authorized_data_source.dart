import 'package:starter/features/auth/data/auth_api.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/model/user.dart';

class RemoteAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  final AuthApi _authApi;

  const RemoteAuthAuthorizedDataSource(this._authApi);

  @override
  Future<User> getUserProfile() => _authApi.getUserProfile();

  @override
  Future<void> logout() => _authApi.logout();
}
