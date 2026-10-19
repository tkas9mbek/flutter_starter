import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/widgets/form/app_checkbox.dart';
import 'package:starter_uikit/widgets/form/decoration/field_error_text.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';

/// FormBuilder-backed boolean field rendered as an [AppCheckBox] with a
/// label; tapping toggles the value unless [onPressed] takes over.
class AppCheckboxField extends StatelessWidget {
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
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            checked: field.value ?? false,
            child: AppTapArea(
              onTap: enabled
                  ? () {
                      if (onPressed == null) {
                        field.didChange(!(field.value ?? false));
                      } else {
                        onPressed?.call();
                      }
                    }
                  : null,
              child: AppCheckBox(
                selected: field.value ?? false,
                enabled: enabled,
                label: label,
              ),
            ),
          ),
          if (!hideErrorText) ...[
            FieldErrorText(
              visible: field.errorText != null,
              errorText: field.errorText,
            ),
          ],
        ],
      ),
    );
  }
}
