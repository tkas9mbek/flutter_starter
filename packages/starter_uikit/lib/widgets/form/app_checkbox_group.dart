import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/form/app_checkbox.dart';
import 'package:starter_uikit/widgets/form/decoration/field_error_text.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

/// FormBuilder-backed multi-select list of bordered [AppCheckBox] rows (the
/// checked ones tinted), storing the chosen [options] as a `Set<T>` value.
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
    return FormBuilderField<Set<T>>(
      name: name,
      initialValue: selected,
      validator: validator,
      onChanged: (value) => onChanged?.call(value ?? {}),
      enabled: enabled,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...options.mapIndexed((index, option) {
            final selected = field.value?.contains(option) ?? false;

            void toggle() {
              final value = field.value is Set<Never>
                  ? <T>{}
                  : <T>{...?field.value};

              if (selected) {
                value.remove(option);
              } else {
                value.add(option);
              }

              field.didChange(value);
            }

            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
              child: AppCard(
                selected: selected && enabled,
                padding: _rowPadding,
                onTap: enabled ? toggle : null,
                child: AppCheckBox(
                  selected: selected,
                  enabled: enabled,
                  label: optionLabelBuilder(option),
                ),
              ),
            );
          }),
          if (showLastDivider) ...[
            const SizedBox(height: 12),
            const ThinHorizontalDivider(),
          ],
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

const _rowPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 14);
