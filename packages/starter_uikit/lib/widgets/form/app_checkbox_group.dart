import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/form/app_checkbox.dart';
import 'package:starter_uikit/widgets/misc/animated_visibility.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

/// FormBuilder-backed multi-select list of [AppCheckBox] rows separated by
/// thin dividers, storing the chosen [options] as a `Set<T>` form value.
class AppCheckboxGroup<T extends Object> extends StatelessWidget {
  const AppCheckboxGroup({
    required this.name,
    required this.options,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.showLastDivider = false,
    this.hideErrorText = true,
    this.enabled = true,
    this.selected,
    this.validator,
    this.onChanged,
    super.key,
  });

  final String name;
  final Set<T> options;
  final ValueChanged<Set<T>>? onChanged;
  final String Function(T value) optionLabelBuilder;
  final FormFieldValidator<Set<T>>? validator;
  final Set<T>? selected;
  final bool showLastDivider;
  final bool hideErrorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return FormBuilderField<Set<T>>(
      name: name,
      initialValue: selected,
      validator: validator,
      onChanged: (value) => onChanged?.call(value ?? {}),
      enabled: enabled,
      builder: (field) => Column(
        children: [
          ...options.mapIndexed((index, option) {
            final selected = field.value?.contains(option) ?? false;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (!enabled) {
                  return;
                }

                final value = field.value is Set<Never>
                    ? <T>{}
                    : <T>{...?field.value};

                if (selected) {
                  value.remove(option);
                } else {
                  value.add(option);
                }

                field.didChange(value);
              },
              child: Column(
                children: [
                  if (index != 0) ...[
                    const ThinHorizontalDivider(),
                    const SizedBox(height: 12),
                  ],
                  AppCheckBox(
                    selected: selected,
                    enabled: enabled,
                    label: optionLabelBuilder(option),
                  ),
                  if (index != options.length - 1) ...[
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            );
          }).toSet(),
          if (showLastDivider) ...[
            const SizedBox(height: 12),
            const ThinHorizontalDivider(),
          ],
          if (!hideErrorText) ...[
            AnimatedVisibility(
              visible: field.errorText != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '* ${field.errorText ?? ''}',
                  style: textStyles.regularBody14.copyWith(color: theme.error),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
