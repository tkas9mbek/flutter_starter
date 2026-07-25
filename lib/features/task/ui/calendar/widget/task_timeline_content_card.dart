import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class TaskTimelineContentCard extends StatelessWidget {
  const TaskTimelineContentCard({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      onTap: () => context.router.push(TaskDetailsRoute(task: task)),
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
              color: AppColors.blackText.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
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
    );
  }
}
