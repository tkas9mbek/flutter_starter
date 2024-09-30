import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/divider/thin_horizontal_divider.dart';
import 'package:flutter_starter/utils/form/option_label_builders.dart';

class AppRadioGroup<T extends Object> extends StatelessWidget {
  /// A radio group that allows the user to select one option.
  /// The selected option is returned when the form is submitted.
  /// * [options] is a list of options to choose from.
  /// * [optionLabelBuilder] is a function that converts an option to a string.
  const AppRadioGroup({
    required this.name,
    required this.options,
    this.selected,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.showLastDivider = false,
    this.validator,
    this.onChanged,
    super.key,
  });

  final String name;
  final List<T> options;
  final ValueChanged<T?>? onChanged;
  final String Function(T value) optionLabelBuilder;
  final FormFieldValidator<T>? validator;
  final T? selected;
  final bool showLastDivider;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return FormBuilderField<T>(
      name: name,
      initialValue: selected,
      validator: validator,
      onChanged: (value) => onChanged?.call(value),
      builder: (field) => Column(
        children: [
          ...options.mapIndexed(
            (index, option) {
              final selected =  field.value == option;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => field.didChange(option) ,
                child: Column(
                  children: [
                    if (index != 0) ...[
                      const ThinHorizontalDivider(),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                              selected ? theme.primary : theme.border,
                              width: 2,
                            ),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: selected
                                  ? theme.primary
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            optionLabelBuilder(option),
                            style: textStyles.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    if (index != options.length - 1) ...[
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              );
            },
          ).toList(),
          if (showLastDivider) ...[
            const SizedBox(height: 12),
            const ThinHorizontalDivider(),
          ],
        ],
      ),
    );
  }
}
