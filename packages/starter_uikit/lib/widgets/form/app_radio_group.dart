import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

/// FormBuilder-backed single-select list of bordered radio rows (the chosen
/// one tinted), storing the chosen option of [options] as the form value.
class AppRadioGroup<T extends Object> extends StatelessWidget {
  const AppRadioGroup({
    required this.name,
    required this.options,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.showLastDivider = false,
    this.selected,
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
    final textStyles = ThemeProvider.of(context).textStyles;

    return FormBuilderField<T>(
      name: name,
      initialValue: selected,
      validator: validator,
      onChanged: (value) => onChanged?.call(value),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...options.mapIndexed((index, option) {
            final selected = field.value == option;

            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
              child: AppCard(
                selected: selected,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                onTap: () => field.didChange(option),
                child: Row(
                  children: [
                    _RadioDot(selected: selected),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        optionLabelBuilder(option),
                        style: textStyles.regularBody16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (showLastDivider) ...[
            const SizedBox(height: 12),
            const ThinHorizontalDivider(),
          ],
        ],
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 22,
      width: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? theme.primary : AppColors.transparent,
        border: Border.all(
          color: selected ? theme.primary : theme.borderStrong,
          width: 1.5,
        ),
      ),
      child: selected
          ? Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: theme.onPrimary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}
