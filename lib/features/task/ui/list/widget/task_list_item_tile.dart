import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/widget/task_status_pill.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';

class TaskListItemTile extends StatelessWidget {
  const TaskListItemTile({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    final timeFormat = DateFormat('HH:mm');
    final timeRange =
        '${timeFormat.format(task.startTime)} - ${timeFormat.format(task.endTime)}';

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: theme.error,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgIcon(UiSvgIcons.trashDelete, color: theme.onStatus),
          ),
        ),
      ),
      onDismissed: (_) =>
          context.read<TaskDeleteBloc>().add(TaskDeleteEvent.deleted(task.id)),
      child: AppListTile(
        title: task.title,
        subtitle: timeRange,
        trailing: TaskStatusPill(isCompleted: task.isCompleted),
        onTap: () => context.router.push(TaskDetailsRoute(task: task)),
      ),
    );
  }
}
