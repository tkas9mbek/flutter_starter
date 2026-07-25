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
              Container(width: 2, height: 60, color: theme.border),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(child: TaskTimelineContentCard(task: task)),
        ],
      ),
    );
  }
}
