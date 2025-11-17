import 'package:starter/features/auth/data/auth_api.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';

class RemoteProfileDataSource implements ProfileDataSource {
  final AuthApi _authApi;

  const RemoteProfileDataSource(this._authApi);

  @override
  Future<User> getUserProfile() => _authApi.getUserProfile();
}
