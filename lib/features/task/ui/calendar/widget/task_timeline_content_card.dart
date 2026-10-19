import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/list/widget/task_status_pill.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';

class TaskTimelineContentCard extends StatelessWidget {
  const TaskTimelineContentCard({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: () => context.router.push(TaskDetailsRoute(task: task)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(task.title, style: textStyles.mediumBody16)),
              const SizedBox(width: 8),
              TaskStatusPill(isCompleted: task.isCompleted),
            ],
          ),
          if (task.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.regularBody13.copyWith(
                color: theme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
