import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/list/widget/task_date_group_card.dart';
import 'package:starter/features/task/ui/list/widget/tasks_list_loading_skeleton.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/size/fill_remaining_scroll_view.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

/// Maps the task list's load state to the matching body view: date-grouped
/// list, empty state, failure with retry, or loading skeleton.
class TasksListStatusBody extends StatelessWidget {
  const TasksListStatusBody({required this.state, super.key});

  final TasksListState state;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    switch (state) {
      case SuccessTasksListState(:final tasks, :final groupedTasks):
        if (tasks.isEmpty) {
          return FillRemainingScrollView(
            child: EmptyInformationBody(text: localizer.noTasksYet),
          );
        }

        final sortedDates = groupedTasks.keys.toList()
          ..sort((a, b) => a.compareTo(b));

        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: sortedDates.length,
          itemBuilder: (context, index) {
            final date = sortedDates[index];
            final tasksForDate = groupedTasks[date]!;

            return TaskDateGroupCard(date: date, tasks: tasksForDate);
          },
        );
      case FailureTasksListState(:final exception):
        return FillRemainingScrollView(
          child: FailureWidget.large(
            exception: exception,
            onRetry: () => context.read<TasksListBloc>().add(
              const TasksListEvent.requested(),
            ),
          ),
        );
      case InitialTasksListState() || LoadingTasksListState():
        return const TasksListLoadingSkeleton();
    }
  }
}
