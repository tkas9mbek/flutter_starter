import 'package:flutter/material.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/app_time_picker_field.dart';

class TaskCreateFormFields extends StatelessWidget {
  const TaskCreateFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return Column(
      children: [
        AppTextField(
          name: TaskCreateForm.titleField,
          label: localizer.taskTitle,
          hint: localizer.taskTitleHint,
          required: true,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: TaskCreateForm.descriptionField,
          label: localizer.description,
          hint: localizer.taskDescriptionHint,
          minLines: 3,
          maxLines: 5,
        ),
        const SizedBox(height: 16),
        AppDatePickerField(
          name: TaskCreateForm.dateField,
          label: localizer.date,
          hint: localizer.date,
          required: true,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTimePickerField(
                name: TaskCreateForm.startTimeField,
                label: localizer.startTime,
                hint: localizer.startTime,
                required: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTimePickerField(
                name: TaskCreateForm.endTimeField,
                label: localizer.endTime,
                hint: localizer.endTime,
                required: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
