import 'package:starter/features/profile/data/profile_service.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';

class RemoteProfileDataSource implements ProfileDataSource {
  final ProfileService _profileService;

  const RemoteProfileDataSource(this._profileService);

  @override
  Future<User> getUserProfile() => _profileService.getUserProfile();
}
