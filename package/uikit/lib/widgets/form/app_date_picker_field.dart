import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:uikit/generated/l10n.dart';
import 'package:uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:uikit/widgets/form/app_text_field.dart';
import 'package:uikit/widgets/form/decoration/bordered_text_field_decoration.dart';
import 'package:uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:uikit/widgets/form/decoration/text_field_decoration.dart';

class AppDatePickerField extends StatefulWidget {
  /// A date picker field that allows the user to select a date.
  /// The selected date is displayed as a string in the format `dd.MM.yyyy`.
  /// Similar to [AppTextField], but with a date picker.
  const AppDatePickerField({
    required this.name,
    this.label,
    this.hint,
    this.prefixText,
    this.validator,
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
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final String? prefixText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextFieldDecoration decoration;
  final Color? color;

  final DateTime? minDate;
  final DateTime? maxDate;

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

  FormBuilderFieldState<FormBuilderField, dynamic>? controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialValue =
          FormBuilder.of(context)?.initialValue[widget.name] as DateTime?;

      controller = FormBuilder.of(context)?.fields[childName];
      updateChildValue(initialValue);
    });
  }

  void updateChildValue(DateTime? value) {
    if (controller != null) {
      final formatter = DateFormat('dd.MM.yyyy');

      controller!.didChange(value == null ? null : formatter.format(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: widget.name,
      enabled: widget.enabled,
      builder: (form) => AppTextField(
        name: '_${widget.name}',
        onTap: () {
          if (!widget.enabled) {
            return;
          }

          BottomSheetScreen.show(
            context: context,
            enableDrag: false,
            builder: (context) => DateTimePickerBottomSheet(
              title: widget.label ?? '',
              backText: S.of(context).back,
              confirmText: S.of(context).toSelect,
              initialDate: form.value,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
            ),
          ).then(
            (value) {
              if (value is DateTime) {
                form.didChange(value);
                updateChildValue(value);
              }
            },
          );
        },
        color: widget.color,
        label: widget.label,
        hint: widget.hint,
        prefixText: widget.prefixText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: widget.decoration,
        hideErrorText: widget.hideErrorText,
        hasClearButton: widget.hasClearButton,
        colorLabelOnError: widget.colorLabelOnError,
        loading: widget.loading,
        enabled: false,
      ),
    );
  }
}
