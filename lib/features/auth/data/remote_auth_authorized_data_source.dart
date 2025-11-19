import 'package:starter/features/auth/data/auth_service.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';

class RemoteAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  final AuthService _authService;

  const RemoteAuthAuthorizedDataSource(this._authService);

  @override
  Future<void> logout() => _authService.logout();
}
