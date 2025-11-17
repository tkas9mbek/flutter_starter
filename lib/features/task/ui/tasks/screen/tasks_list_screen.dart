import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/tasks/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/tasks/widget/date_group_card.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

@RoutePage()
class TasksListScreen extends StatelessWidget {
  const TasksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksListBloc(getIt<TaskRepository>())
        ..add(const TasksListEvent.loaded()),
      child: const _TasksListView(),
    );
  }
}

class _TasksListView extends StatelessWidget {
  const _TasksListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        title: Localizer.of(context).tasks,
      ),
      body: BlocListener<TasksListBloc, TasksListState>(
        listener: (context, state) => state.whenOrNull(
          failure: (exception) => NotificationSnackBar.showExceptionMessage(
            context,
            exception: exception,
          ),
        ),
        child: BlocBuilder<TasksListBloc, TasksListState>(
          builder: (context, state) => state.maybeMap(
            success: (successState) {
              final tasks = successState.tasks;
              final groupedTasks = successState.groupedTasks;

              if (tasks.isEmpty) {
                return EmptyInformationBody(
                  text: Localizer.of(context).noTasksYet,
                );
              }

              final sortedDates = groupedTasks.keys.toList()
                ..sort((a, b) => a.compareTo(b));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final tasksForDate = groupedTasks[date]!;

                  return DateGroupCard(
                    date: date,
                    tasks: tasksForDate,
                  );
                },
              );
            },
            failure: (failureState) => FailureWidgetLarge(
              exception: failureState.exception,
              onRetry: () => context.read<TasksListBloc>().add(
                    const TasksListEvent.loaded(),
                  ),
            ),
            orElse: () => const CustomCircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
