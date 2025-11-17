import 'package:starter/features/auth/data/auth_api.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';

class RemoteAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  final AuthApi _authApi;

  const RemoteAuthAuthorizedDataSource(this._authApi);

  @override
  Future<void> logout() => _authApi.logout();
}
