import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/list/widget/task_date_group_card.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

@RoutePage()
class TasksListScreen extends StatelessWidget {
  const TasksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksListBloc(getIt<TaskRepository>())
            ..add(const TasksListEvent.requested()),
        ),
        BlocProvider(
          create: (context) => TaskDeleteBloc(getIt<TaskRepository>()),
        ),
      ],
      child: const _TasksListView(),
    );
  }
}

class _TasksListView extends StatelessWidget {
  const _TasksListView();

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocListener<TaskDeleteBloc, TaskDeleteState>(
      listener: (context, state) {
        state.mapOrNull(
          success: (_) {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: true,
              message: localizer.taskDeletedSuccessfully,
            );
            context.read<TasksListBloc>().add(
                  const TasksListEvent.requested(),
                );
          },
          failure: (failureState) {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: false,
              message: localizer.failedToDeleteTask,
            );
          },
        );
      },
      child: Scaffold(
        appBar: TitleAppBar(title: localizer.tasks),
        body: BlocBuilder<TasksListBloc, TasksListState>(
          builder: (context, state) => state.maybeMap(
            success: (successState) {
              final tasks = successState.tasks;
              final groupedTasks = successState.groupedTasks;

              if (tasks.isEmpty) {
                return EmptyInformationBody(text: localizer.noTasksYet);
              }

              final sortedDates = groupedTasks.keys.toList()
                ..sort((a, b) => a.compareTo(b));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final tasksForDate = groupedTasks[date]!;

                  return TaskDateGroupCard(
                    date: date,
                    tasks: tasksForDate,
                  );
                },
              );
            },
            failure: (failureState) => FailureWidgetLarge(
              exception: failureState.exception,
              onRetry: () => context.read<TasksListBloc>().add(
                    const TasksListEvent.requested(),
                  ),
            ),
            orElse: () => const CustomCircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
