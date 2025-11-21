import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_field.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class FormFieldsExampleScreen extends StatelessWidget {
  FormFieldsExampleScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.formFields),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                localizer.textField,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              AppTextField(
                name: 'text_field',
                label: localizer.textField,
                hint: localizer.enterText,
              ),
              const SizedBox(height: 24),
              Text(
                localizer.dropdownField,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              AppDropdownField<String>(
                name: 'dropdown_field',
                label: localizer.dropdownField,
                hint: localizer.selectOption,
                options: const ['option1', 'option2', 'option3'],
                optionLabelBuilder: (value) {
                  switch (value) {
                    case 'option1':
                      return localizer.option1;
                    case 'option2':
                      return localizer.option2;
                    case 'option3':
                      return localizer.option3;
                    default:
                      return value;
                  }
                },
              ),
              const SizedBox(height: 24),
              Text(
                localizer.datePickerField,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              AppDatePickerField(
                name: 'date_field',
                label: localizer.datePickerField,
                minDate: DateTime(1900),
                maxDate: DateTime.now(),
              ),
              const SizedBox(height: 24),
              Text(
                localizer.checkboxField,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              AppCheckboxField(
                name: 'checkbox_field',
                label: localizer.agreeToTerms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
