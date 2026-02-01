import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class ProfileRepository {
  ProfileRepository(this._repositoryExecutor, this._profileDataSource);

  final RepositoryExecutor _repositoryExecutor;
  final ProfileDataSource _profileDataSource;

  Future<User> getUserProfile() =>
      _repositoryExecutor.execute(_profileDataSource.getUserProfile);
}
