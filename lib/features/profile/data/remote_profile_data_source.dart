import 'package:starter/features/auth/data/auth_service.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';

class RemoteProfileDataSource implements ProfileDataSource {
  final AuthService _authService;

  const RemoteProfileDataSource(this._authService);

  @override
  Future<User> getUserProfile() => _authService.getUserProfile();
}
