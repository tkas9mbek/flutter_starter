import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_starter/uikit/divider/thin_horizontal_divider.dart';
import 'package:flutter_starter/uikit/form/app_checkbox.dart';
import 'package:flutter_starter/utils/form/option_label_builders.dart';

class AppCheckboxGroup<T extends Object> extends StatelessWidget {
  /// A checkbox group that allows the user to select multiple options.
  /// The selected options are returned as a list when the form is submitted.
  /// * [options] is a list of options to choose from.
  /// * [optionLabelBuilder] is a function that converts an option to a string.
  /// By default, it uses the `toString` method.
  const AppCheckboxGroup({
    required this.name,
    required this.options,
    this.selected,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.showLastDivider = false,
    this.hideErrorText = true,
    this.enabled = true,
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
    return FormBuilderField<Set<T>>(
      name: name,
      initialValue: selected,
      validator: validator,
      onChanged: (value) => onChanged?.call(value ?? {}),
      enabled: enabled,
      builder: (field) => Column(
        children: [
          ...options.mapIndexed(
            (index, option) {
              final selected = field.value?.contains(option) ?? false;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (!enabled) {
                    return;
                  }

                  final value =
                      field.value is Set<Never> ? <T>{} : <T>{...?field.value};

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
            },
          ).toSet(),
          if (showLastDivider) ...[
            const SizedBox(height: 12),
            const ThinHorizontalDivider(),
          ],
        ],
      ),
    );
  }
}
