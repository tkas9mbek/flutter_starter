import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/list/widget/task_list_item_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

class TaskDateGroupCard extends StatelessWidget {
  const TaskDateGroupCard({required this.date, required this.tasks, super.key});

  final DateTime date;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    final dateLabel = _getDateLabel(context, date);
    final tasksCount = tasks.length;
    final tasksWord = _getTasksWord(context, tasksCount);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Text(
                  dateLabel,
                  style: textStyles.mediumBody13.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$tasksCount $tasksWord',
                  style: textStyles.regularBody13.copyWith(
                    color: theme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          GroupedRowsCard(
            children: [
              for (final task in tasks) ...[TaskListItemTile(task: task)],
            ],
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
