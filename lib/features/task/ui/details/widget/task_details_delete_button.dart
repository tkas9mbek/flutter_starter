import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

class TaskDetailsDeleteButton extends StatelessWidget {
  const TaskDetailsDeleteButton({
    required this.taskId,
    super.key,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocBuilder<TaskDeleteBloc, TaskDeleteState>(
      builder: (context, state) => AppOutlinedButton.medium(
        context: context,
        text: localizer.deleteTask,
        loading: state.isLoading,
        onPressed: () => _showDeleteConfirmation(context),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final localizer = Localizer.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizer.deleteTask),
        content: Text(localizer.deleteTaskConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(localizer.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(localizer.delete),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && context.mounted) {
      context.read<TaskDeleteBloc>().add(TaskDeleteEvent.deleted(taskId));
    }
  }
}
