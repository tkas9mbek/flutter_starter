
import 'package:flutter/material.dart';
import 'package:flutter_starter/uikit/dialogs/bottom_sheet_screen.dart';
import 'package:flutter_starter/uikit/form/app_radio_group.dart';
import 'package:flutter_starter/utils/form/option_label_builders.dart';

class NoValue {}

class DropdownBottomSheet<T extends Object> extends StatelessWidget {
  /// A bottom sheet that allows the user to select an option from a list.
  /// The user can select only one option.
  /// The selected option is returned when the bottom sheet is closed.
  /// If the user cancels the selection, the bottom sheet returns `null`.
  /// * [options] is a list of options to choose from.
  /// * [optionLabelBuilder] is a function that converts an option to a string.
  /// By default, it uses the `toString` method.
  const DropdownBottomSheet({
    required this.options,
    this.selected,
    this.title,
    this.showCloseButton = true,
    this.showResizeIndicator = true,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          AppRadioGroup(
            name: '_checkbox',
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
