import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';

class AppDatePickerField extends StatefulWidget {
  const AppDatePickerField({
    required this.name,
    this.label,
    this.hint,
    this.prefix,
    this.validators,
    this.onChanged,
    this.color,
    this.minDate,
    this.maxDate,
    this.decoration = const FilledTextFieldDecoration(),
    this.enabled = true,
    this.hideErrorText = false,
    this.hasClearButton = false,
    this.colorLabelOnError = false,
    this.loading = false,
    this.required = false,
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final Widget? prefix;
  final List<FormFieldValidator<DateTime>>? validators;
  final Function(DateTime?)? onChanged;
  final TextFieldDecoration decoration;
  final Color? color;

  final DateTime? minDate;
  final DateTime? maxDate;

  final bool required;
  final bool hideErrorText;
  final bool hasClearButton;
  final bool colorLabelOnError;
  final bool loading;
  final bool enabled;

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  late final childName = '_${widget.name}';

  FormBuilderFieldState<FormBuilderField, dynamic>? textController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      textController = FormBuilder.of(context)?.fields[childName];
    });
  }

  void updateChildValue(DateTime? value) {
    if (textController != null) {
      final formatter = DateFormat('dd.MM.yyyy');
      textController!.didChange(value == null ? null : formatter.format(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: widget.name,
      enabled: widget.enabled,
      validator: FormBuilderValidators.compose([
        ...?widget.validators,
        if (widget.required) FormBuilderValidators.required(),
      ]),
      builder: (form) => AppTextField(
        name: childName,
        onTap: () {
          if (!widget.enabled) {
            return;
          }

          BottomSheetScreen.show(
            context: context,
            enableDrag: false,
            builder: (context) => DateTimePickerBottomSheet(
              title: widget.label ?? '',
              backText: UikitLocalizer.of(context).back,
              confirmText: UikitLocalizer.of(context).toSelect,
              initialDate: form.value,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
            ),
          ).then(
            (value) {
              if (value is DateTime) {
                form.didChange(value);
                updateChildValue(value);
                widget.onChanged?.call(value);
              }
            },
          );
        },
        color: widget.color,
        label: widget.label,
        hint: widget.hint,
        prefix: widget.prefix,
        decoration: widget.decoration,
        hideErrorText: widget.hideErrorText,
        hasClearButton: widget.hasClearButton,
        colorLabelOnError: widget.colorLabelOnError,
        loading: widget.loading,
        readOnly: true,
        validators: [(_) => form.errorText],
        initialValue: form.value == null
            ? null
            : DateFormat('dd.MM.yyyy').format(form.value!),
      ),
    );
  }
}
