import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/profile/data/mock_profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class ProfileModule extends AppModule {
  @override
  void registerDependencies() {
    getIt
      ..registerLazySingleton<ProfileDataSource>(
        () => MockProfileDataSource(),
      )
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepository(
          getIt<RepositoryExecutor>(),
          getIt<ProfileDataSource>(),
        ),
      );
  }
}
