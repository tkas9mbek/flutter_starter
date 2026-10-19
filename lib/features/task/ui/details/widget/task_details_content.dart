import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/list/widget/task_status_pill.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

class TaskDetailsContent extends StatelessWidget {
  const TaskDetailsContent({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(task.title, style: textStyles.mediumTitle20),
        const SizedBox(height: 24),
        GroupedRowsCard(
          children: [
            AppListTile(
              icon: UiSvgIcons.calendarDates,
              title: localizer.calendar,
              value: DateFormat('dd MMMM yyyy', 'ru').format(task.date),
            ),
            AppListTile(
              icon: UiSvgIcons.clockTime,
              title: localizer.startTime,
              value: DateFormat('HH:mm').format(task.startTime),
            ),
            AppListTile(
              icon: UiSvgIcons.clockTime,
              title: localizer.endTime,
              value: DateFormat('HH:mm').format(task.endTime),
            ),
            AppListTile(
              icon: UiSvgIcons.checkMark,
              title: localizer.status,
              trailing: TaskStatusPill(isCompleted: task.isCompleted),
            ),
          ],
        ),
        if (task.description.isNotEmpty) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              localizer.description,
              style: textStyles.mediumBody13.copyWith(
                color: theme.textSecondary,
              ),
            ),
          ),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Text(task.description, style: textStyles.regularBody14),
          ),
        ],
      ],
    );
  }
}
