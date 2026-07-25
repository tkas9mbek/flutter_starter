import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/profile/data/mock_profile_data_source.dart';
import 'package:starter/features/profile/data/remote_profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/ui/overview/bloc/user_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class ProfileModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    unregisterIfRegistered<UserBloc>,
    unregisterIfRegistered<ProfileRepository>,
    unregisterIfRegistered<ProfileDataSource>,
  ];

  @override
  void register() {
    getIt
      ..registerLazySingleton<ProfileDataSource>(() {
        if (useMock) {
          return const MockProfileDataSource();
        }

        return RemoteProfileDataSource(getIt<ApiClient>());
      })
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepository(
          const RawRepositoryExecutor().withErrorHandling().withRetry(
            maxRetries: 3,
            retryDelay: const Duration(seconds: 2),
          ),
          getIt<ProfileDataSource>(),
        ),
      )
      ..registerFactory(() => UserBloc(getIt<ProfileRepository>()));
  }
}
