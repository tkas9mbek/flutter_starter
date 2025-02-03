import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:uikit/widgets/form/app_checkbox.dart';

class AppCheckboxField extends StatelessWidget {
  /// A checkbox field that allows the user to select a boolean value.
  const AppCheckboxField({
    required this.name,
    required this.label,
    this.hideErrorText = true,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onPressed,
    super.key,
  });

  final String name;
  final String label;
  final bool hideErrorText;
  final bool enabled;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onChanged;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
      name: name,
      validator: validator,
      onChanged: (value) => onChanged?.call(value ?? false),
      enabled: enabled,
      builder: (field) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (!enabled) {
            return;
          }

          if (onPressed == null) {
            field.didChange(!(field.value ?? false));
          } else {
            onPressed?.call();
          }
        },
        child: AppCheckBox(
          selected: field.value ?? false,
          enabled: enabled,
          label: label,
        ),
      ),
    );
  }
}
