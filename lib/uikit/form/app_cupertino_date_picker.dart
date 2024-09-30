import 'package:flutter/material.dart';
import 'package:flutter_starter/external/customizable_cupertino_date_picker.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class AppCupertinoDatePicker extends StatelessWidget {
  const AppCupertinoDatePicker({
    required this.onSelectedItemChanged,
    this.minDate,
    this.maxDate,
    this.selectedDate,
    super.key,
  });

  final void Function(DateTime) onSelectedItemChanged;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return CustomizableCupertinoDatePicker(
      onSelectedItemChanged: onSelectedItemChanged,
      minDate: minDate,
      maxDate: maxDate,
      selectedDate: selectedDate,
      useMaginifier: true,
      itemExtent: 35,
      selectionOverlay: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: theme.border,
              width: 1,
            ),
          ),
        ),
      ),
      selectedStyle: textStyles.titleMedium,
      unselectedStyle: textStyles.labelLarge.copyWith(
        color: theme.onBackground,
      ),
      disabledStyle: textStyles.labelLarge.copyWith(
        color: theme.onBackground.withOpacity(0.75),
      ),
    );
  }
}
