import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

class TaskListItemTile extends StatelessWidget {
  const TaskListItemTile({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    final timeFormat = DateFormat('HH:mm');
    final timeRange =
        '${timeFormat.format(task.startTime)} - ${timeFormat.format(task.endTime)}';

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgIcon(UiSvgIcons.trashDelete, size: 28, color: theme.onStatus),
      ),
      onDismissed: (_) =>
          context.read<TaskDeleteBloc>().add(TaskDeleteEvent.deleted(task.id)),
      child: InkWell(
        onTap: () => context.router.push(TaskDetailsRoute(task: task)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: task.isCompleted
                          ? textStyles.mediumBody14.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: theme.textSecondary,
                            )
                          : textStyles.mediumBody14,
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        style: textStyles.regularBody12.copyWith(
                          color: theme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgIcon(
                          UiSvgIcons.clockTime,
                          size: 14,
                          color: theme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeRange,
                          style: textStyles.regularBody12.copyWith(
                            color: theme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
