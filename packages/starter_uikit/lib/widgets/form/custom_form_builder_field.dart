import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class CustomFormBuilderField<T> extends StatelessWidget {
  const CustomFormBuilderField({
    required this.name,
    required this.builder,
    this.validator,
    this.onChanged,
    this.initialValue,
    super.key,
  });

  final String name;
  final Widget Function(FormFieldState<T>) builder;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;
  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return FormBuilderField<T>(
      name: name,
      onChanged: onChanged,
      initialValue: initialValue,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (field.errorText != null) ...[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.error.withValues(alpha: 0.1),
              ),
              child: Text(
                field.errorText!,
                style: textStyles.regularBody13.copyWith(
                  color: theme.error,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          builder(field),
        ],
      ),
      validator: validator,
    );
  }
}
