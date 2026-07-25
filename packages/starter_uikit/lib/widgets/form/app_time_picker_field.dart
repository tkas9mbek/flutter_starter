import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';

/// FormBuilder field that picks a [TimeOfDay] via [TimePickerBottomSheet];
/// the time-of-day counterpart to `AppDatePickerField`.
class AppTimePickerField extends StatefulWidget {
  const AppTimePickerField({
    required this.name,
    this.decoration = const FilledTextFieldDecoration(),
    this.enabled = true,
    this.hideErrorText = false,
    this.colorLabelOnError = false,
    this.required = false,
    this.label,
    this.hint,
    this.prefix,
    this.validators,
    this.onChanged,
    this.color,
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final Widget? prefix;
  final List<FormFieldValidator<TimeOfDay>>? validators;
  final Function(TimeOfDay?)? onChanged;
  final TextFieldDecoration decoration;
  final Color? color;

  final bool required;
  final bool hideErrorText;
  final bool colorLabelOnError;
  final bool enabled;

  @override
  State<AppTimePickerField> createState() => _AppTimePickerFieldState();
}

class _AppTimePickerFieldState extends State<AppTimePickerField> {
  late final childName = '_${widget.name}';

  FormBuilderFieldState<FormBuilderField, dynamic>? textController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => textController = FormBuilder.of(context)?.fields[childName],
    );
  }

  void updateChildValue(TimeOfDay? value) {
    if (textController != null) {
      textController!.didChange(value?.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<TimeOfDay>(
      name: widget.name,
      enabled: widget.enabled,
      validator: FormBuilderValidators.compose([
        ...?widget.validators,
        if (widget.required) ...[FormBuilderValidators.required()],
      ]),
      builder: (form) => AppTextField(
        name: childName,
        onTap: () {
          if (!widget.enabled) {
            return;
          }

          unawaited(
            BottomSheetScreen.show(
              context: context,
              enableDrag: false,
              builder: (context) => TimePickerBottomSheet(
                title: widget.label ?? '',
                backText: UikitLocalizer.of(context).back,
                confirmText: UikitLocalizer.of(context).toSelect,
                initialTime: form.value,
              ),
            ).then((value) {
              if (value is TimeOfDay) {
                form.didChange(value);
                updateChildValue(value);
                widget.onChanged?.call(value);
              }
            }),
          );
        },
        color: widget.color,
        label: widget.label,
        hint: widget.hint,
        prefix: widget.prefix,
        decoration: widget.decoration,
        hideErrorText: widget.hideErrorText,
        colorLabelOnError: widget.colorLabelOnError,
        readOnly: true,
        validators: [(_) => form.errorText],
        initialValue: form.value?.format(context),
      ),
    );
  }
}
