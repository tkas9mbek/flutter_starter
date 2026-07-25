import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/details/widget/task_details_content.dart';
import 'package:starter/features/task/ui/details/widget/task_details_delete_button.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({required this.task, super.key});

  final Task task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocProvider(
      create: (context) => getIt<TaskDeleteBloc>(),
      child: BlocListener<TaskDeleteBloc, TaskDeleteState>(
        listener: (context, state) {
          if (state is SuccessTaskDeleteState) {
            NotificationSnackBar.show(
              context,
              NotificationSnackBar.success(
                text: localizer.taskDeletedSuccessfully,
              ),
            );
            unawaited(context.router.maybePop());
          }

          if (state is FailureTaskDeleteState) {
            NotificationSnackBar.show(
              context,
              NotificationSnackBar.error(text: localizer.failedToDeleteTask),
            );
          }
        },
        child: Scaffold(
          appBar: TitleAppBar(title: localizer.taskDetails),
          body: Column(
            children: [
              Expanded(child: TaskDetailsContent(task: widget.task)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TaskDetailsDeleteButton(taskId: widget.task.id),
              ),
              const SafeVerticalBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
