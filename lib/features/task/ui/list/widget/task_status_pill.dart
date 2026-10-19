import 'package:flutter/material.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';

class TaskStatusPill extends StatelessWidget {
  const TaskStatusPill({required this.isCompleted, super.key});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;

    return StatusPill(
      label: isCompleted ? localizer.completed : localizer.notCompleted,
      color: isCompleted ? theme.success : theme.info,
    );
  }
}
