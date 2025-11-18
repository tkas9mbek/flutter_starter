import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class TaskDetailsContent extends StatelessWidget {
  const TaskDetailsContent({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          task.title,
          style: textStyles.boldBody16,
        ),
        const SizedBox(height: 24),
        _DetailRow(
          icon: Icons.calendar_today,
          label: localizer.calendar,
          value: DateFormat('dd MMMM yyyy', 'ru').format(task.date),
        ),
        const SizedBox(height: 16),
        _DetailRow(
          icon: Icons.access_time,
          label: localizer.startTime,
          value: DateFormat('HH:mm').format(task.startTime),
        ),
        const SizedBox(height: 16),
        _DetailRow(
          icon: Icons.access_time_filled,
          label: localizer.endTime,
          value: DateFormat('HH:mm').format(task.endTime),
        ),
        const SizedBox(height: 16),
        _DetailRow(
          icon: Icons.check_circle_outline,
          label: localizer.status,
          value:
              task.isCompleted ? localizer.completed : localizer.notCompleted,
        ),
        const SizedBox(height: 24),
        Text(
          localizer.description,
          style: textStyles.boldBody16.copyWith(
            color: theme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          task.description,
          style: textStyles.regularBody14,
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.textSecondary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textStyles.regularBody12.copyWith(
                  color: theme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: textStyles.mediumBody14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
