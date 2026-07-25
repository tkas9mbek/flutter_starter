import 'package:flutter/material.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/form/app_radio_group.dart';

/// Sentinel type for dropdown options, letting a "no selection" entry be
/// distinguished from a `null` result caused by dismissing the sheet.
class NoValue {}

/// A bottom sheet presenting [options] as a radio group for single selection.
/// Pops with the tapped option as soon as it is chosen, or with `null`
/// when the sheet is dismissed. Labels come from [optionLabelBuilder].
class DropdownBottomSheet<T extends Object> extends StatelessWidget {
  const DropdownBottomSheet({
    required this.options,
    this.showCloseButton = true,
    this.showResizeIndicator = true,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.selected,
    this.title,
    super.key,
  });

  final String? title;
  final bool showCloseButton;
  final bool showResizeIndicator;
  final List<T> options;
  final String Function(T value) optionLabelBuilder;
  final T? selected;

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreen(
      title: title,
      showCloseButton: showCloseButton,
      showResizeIndicator: showResizeIndicator,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          AppRadioGroup(
            name: '_option',
            optionLabelBuilder: optionLabelBuilder,
            options: options,
            selected: selected,
            onChanged: (value) => Navigator.pop(context, value),
          ),
        ],
      ),
    );
  }
}
