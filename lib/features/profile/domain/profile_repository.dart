import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class ProfileRepository {
  final RepositoryExecutor _repositoryExecutor;
  final ProfileDataSource _profileDataSource;

  ProfileRepository(
    this._repositoryExecutor,
    this._profileDataSource,
  );

  Future<User> getUserProfile() =>
      _repositoryExecutor.execute(_profileDataSource.getUserProfile);
}
