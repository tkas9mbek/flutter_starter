import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/task/ui/create/bloc/task_creation_bloc.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';
import 'package:starter/features/task/ui/create/widget/task_create_form_fields.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/save_and_validate_form.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/misc/unfocus_area.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

/// Pops with `true` on success so the caller can refresh its list.
@RoutePage()
class TaskCreateScreen extends StatelessWidget {
  const TaskCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCreationBloc>(
      create: (context) => getIt<TaskCreationBloc>(),
      child: const _TaskCreateView(),
    );
  }
}

class _TaskCreateView extends StatefulWidget {
  const _TaskCreateView();

  @override
  State<_TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<_TaskCreateView> {
  final formKey = GlobalKey<FormBuilderState>();

  void onSubmitted(BuildContext context) {
    if (!saveAndValidateForm(formKey)) {
      return;
    }

    final form = TaskCreateForm.fromForm(formKey.currentState!.value);
    context.read<TaskCreationBloc>().add(TaskCreationEvent.submitted(form));
  }

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocConsumer<TaskCreationBloc, TaskCreationState>(
      listener: (context, state) {
        if (state is SuccessTaskCreationState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(
              text: localizer.taskCreatedSuccessfully,
            ),
          );
          unawaited(context.router.maybePop(true));
        }

        if (state case FailureTaskCreationState(:final exception)) {
          NotificationSnackBar.showExceptionMessage(
            context,
            exception: exception,
          );
        }
      },
      builder: (context, state) => FormBuilder(
        key: formKey,
        child: UnfocusArea(
          child: Scaffold(
            appBar: TitleAppBar(title: localizer.createTask),
            body: Column(
              children: [
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: TaskCreateFormFields(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppElevatedButton.big(
                    context: context,
                    text: localizer.create,
                    loading: state.isLoading,
                    onPressed: () => onSubmitted(context),
                  ),
                ),
                const SafeVerticalBox(bottom: true, height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
