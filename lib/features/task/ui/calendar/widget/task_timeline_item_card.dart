import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/details/bloc/task_toggle_bloc.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class TaskTimelineItemCard extends StatelessWidget {
  const TaskTimelineItemCard({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeFormat.format(task.startTime),
                  style: textStyles.mediumBody12.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeFormat.format(task.endTime),
                  style: textStyles.regularBody10.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: task.isCompleted ? theme.primary : theme.border,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: theme.border,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => context.router.push(
                TaskDetailsRoute(task: task),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: task.isCompleted ? theme.primary : theme.border,
                    width: task.isCompleted ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) {
                            context.read<TaskToggleBloc>().add(
                                  TaskToggleEvent.toggled(task.id),
                                );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            task.title,
                            style: task.isCompleted
                                ? textStyles.mediumBody14.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: theme.textSecondary,
                                  )
                                : textStyles.mediumBody14,
                          ),
                        ),
                      ],
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        task.description,
                        style: textStyles.regularBody12.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
