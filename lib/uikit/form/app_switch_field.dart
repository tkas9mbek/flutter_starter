import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/form/app_switch.dart';

class AppSwitchField extends StatelessWidget {
  const AppSwitchField({
    required this.name,
    required this.label,
    this.switchWidth = 39,
    this.switchDirection = TextDirection.ltr,
    this.validator,
    this.color,
    this.onChanged,
    super.key,
  });

  final String name;
  final String label;
  final TextDirection switchDirection;
  final FormFieldValidator<bool>? validator;
  final ValueChanged<bool?>? onChanged;
  final Color? color;
  final double switchWidth;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return FormBuilderField<bool>(
      name: name,
      validator: validator,
      onChanged: (value) => onChanged?.call(value),
      builder: (field) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (switchDirection == TextDirection.ltr) ...[
            AppSwitch.small(
              value: field.value ?? false,
              onChanged: field.didChange,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              label,
              style: textStyles.bodyMedium,
            ),
          ),
          if (switchDirection == TextDirection.rtl) ...[
            const SizedBox(width: 8),
            AppSwitch(
              value: field.value ?? false,
              onChanged: field.didChange,
              color: color,
              width: switchWidth,
              switchSize: 21 / 39 * switchWidth,
              switchPadding: EdgeInsets.all(1.5 / 39 * switchWidth),
            ),
          ],
        ],
      ),
    );
  }
}
