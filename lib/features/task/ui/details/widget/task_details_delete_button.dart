import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/details/widget/delete_task_dialog.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

class TaskDetailsDeleteButton extends StatelessWidget {
  const TaskDetailsDeleteButton({required this.taskId, super.key});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return BlocBuilder<TaskDeleteBloc, TaskDeleteState>(
      builder: (context, state) => AppElevatedButton(
        height: 48,
        width: double.infinity,
        borderRadius: AppRadii.control,
        text: localizer.deleteTask,
        textStyle: textStyles.mediumBody16,
        backgroundColor: theme.error,
        textColor: theme.onStatus,
        loading: state.isLoading,
        onPressed: () => _showDeleteConfirmation(context),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await DeleteTaskDialog.confirm(context);

    if (confirmed && context.mounted) {
      context.read<TaskDeleteBloc>().add(TaskDeleteEvent.deleted(taskId));
    }
  }
}
