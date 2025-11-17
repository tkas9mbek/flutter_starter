import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/tasks/widget/task_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/starter_uikit.dart';

class DateGroupCard extends StatelessWidget {
  const DateGroupCard({
    required this.date,
    required this.tasks,
    super.key,
  });

  final DateTime date;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    final dateLabel = _getDateLabel(context, date);
    final tasksCount = tasks.length;
    final tasksWord = _getTasksWord(context, tasksCount);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Row(
              children: [
                Text(
                  dateLabel,
                  style: textStyles.boldBody16,
                ),
                const SizedBox(width: 8),
                Text(
                  '$tasksCount $tasksWord',
                  style: textStyles.regularBody14.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: theme.border,
              ),
              itemBuilder: (context, index) => TaskTile(task: tasks[index]),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateLabel(BuildContext context, DateTime date) {
    if (date.isToday) {
      return Localizer.of(context).today;
    }

    if (date.isTomorrow) {
      return Localizer.of(context).tomorrow;
    }

    return DateFormat('EEEE, MMMM d').format(date);
  }

  String _getTasksWord(BuildContext context, int count) {
    if (count == 1) {
      return Localizer.of(context).task;
    }

    if (count >= 2 && count <= 4) {
      return Localizer.of(context).tasks_plural;
    }

    return Localizer.of(context).tasks_many;
  }
}
