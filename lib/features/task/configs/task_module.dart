import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/task/data/mock_task_data_source.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/data/task_service.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class TaskModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  Future<void> registerDependencies() async {
    final getIt = GetIt.instance;
    getIt
      ..registerFactory<TaskService>(
        () => TaskService(getIt<Dio>()),
      )
      ..registerFactory<TaskDataSource>(
        () {
          final env = getIt<AppEnvironment>();

          if (env.useMock) {
            return MockTaskDataSource();
          }

          return RemoteTaskDataSource(getIt<TaskService>());
        },
      )
      ..registerFactory(
        () => TaskRepository(
          const RawRepositoryExecutor().withErrorHandling(),
          getIt<TaskDataSource>(),
        ),
      )
      ..registerFactory(
        () => CalendarBloc(getIt<TaskRepository>()),
      )
      ..registerFactory(
        () => TasksListBloc(getIt<TaskRepository>()),
      );
  }
}
