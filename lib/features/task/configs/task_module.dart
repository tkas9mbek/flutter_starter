import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/task/data/mock_task_data_source.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/data/task_api.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/tasks/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/repository_executor/caching_repository_executor.dart';

class TaskModule extends AppModule {
  @override
  Future<void> registerDependencies() async {
    final getIt = GetIt.instance;
    // API
    getIt.registerFactory<TaskApi>(
      () => TaskApi(getIt<Dio>()),
    );

    // DataSource - Use Mock in Dev, Remote in Prod
    getIt.registerFactory<TaskDataSource>(
      () {
        final env = getIt<AppEnvironment>();

        if (env.name == 'dev') {
          return MockTaskDataSource();
        }

        return RemoteTaskDataSource(getIt<TaskApi>());
      },
    );

    // Repository with Caching Executor
    getIt.registerFactory(
      () => TaskRepository(
        CachingRepositoryExecutor(
          cacheDuration: const Duration(minutes: 5), // Cache tasks for 5 minutes
        ),
        getIt<TaskDataSource>(),
      ),
    );

    // BLoCs
    getIt.registerFactory(
      () => CalendarBloc(getIt<TaskRepository>()),
    );

    getIt.registerFactory(
      () => TasksListBloc(getIt<TaskRepository>()),
    );
  }
}
