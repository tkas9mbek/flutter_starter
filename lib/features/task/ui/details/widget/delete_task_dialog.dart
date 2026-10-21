import 'package:flutter/material.dart';
import 'package:starter/l10n/generated/l10n.dart';

/// Asks the user to confirm deleting a task; used wherever a task can be deleted.
class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({super.key});

  /// Resolves to `true` only when the user confirms.
  static Future<bool> confirm(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteTaskDialog(),
    );

    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return AlertDialog(
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
    );
  }
}
