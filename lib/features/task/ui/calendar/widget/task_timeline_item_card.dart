import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/calendar/widget/task_timeline_content_card.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class TaskTimelineItemCard extends StatelessWidget {
  const TaskTimelineItemCard({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final timeFormat = DateFormat('HH:mm');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: MediaQuery.withClampedTextScaling(
              maxScaleFactor: 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeFormat.format(task.startTime),
                    style: textStyles.mediumBody13.copyWith(
                      color: theme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timeFormat.format(task.endTime),
                    style: textStyles.regularBody12.copyWith(
                      color: theme.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: task.isCompleted ? theme.accent : theme.border,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 1, height: 60, color: theme.border),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(child: TaskTimelineContentCard(task: task)),
        ],
      ),
    );
  }
}
