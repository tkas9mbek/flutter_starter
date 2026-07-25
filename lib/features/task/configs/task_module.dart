import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/task/data/mock_task_data_source.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/create/bloc/task_creation_bloc.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class TaskModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    unregisterIfRegistered<TaskDeleteBloc>,
    unregisterIfRegistered<TaskCreationBloc>,
    unregisterIfRegistered<TasksSearchBloc>,
    unregisterIfRegistered<TasksListBloc>,
    unregisterIfRegistered<CalendarBloc>,
    unregisterIfRegistered<TaskRepository>,
    unregisterIfRegistered<TaskDataSource>,
  ];

  @override
  void register() {
    getIt
      ..registerFactory<TaskDataSource>(() {
        if (useMock) {
          return MockTaskDataSource();
        }

        return RemoteTaskDataSource(getIt<ApiClient>());
      })
      ..registerFactory(
        () => TaskRepository(
          const RawRepositoryExecutor().withErrorHandling(),
          getIt<TaskDataSource>(),
        ),
      )
      ..registerFactory(() => CalendarBloc(getIt<TaskRepository>()))
      ..registerFactory(() => TasksListBloc(getIt<TaskRepository>()))
      ..registerFactory(() => TasksSearchBloc(getIt<TaskRepository>()))
      ..registerFactory(() => TaskCreationBloc(getIt<TaskRepository>()))
      ..registerFactory(() => TaskDeleteBloc(getIt<TaskRepository>()));
  }
}
