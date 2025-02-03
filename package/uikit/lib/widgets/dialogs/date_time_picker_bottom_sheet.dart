import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/button/app_base_button.dart';
import 'package:uikit/widgets/dialogs/app_cupertino_date_picker.dart';
import 'package:uikit/widgets/dialogs/bottom_sheet_screen.dart';

class DateTimePickerBottomSheet extends StatefulWidget {
  /// A bottom sheet that allows the user to select a date.
  const DateTimePickerBottomSheet({
    required this.title,
    required this.backText,
    required this.confirmText,
    this.onDateSelected,
    this.initialDate,
    this.minDate,
    this.maxDate,
    super.key,
  });

  final String title;
  final String backText;
  final String confirmText;
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final void Function(BuildContext, DateTime)? onDateSelected;

  @override
  State<DateTimePickerBottomSheet> createState() =>
      _DateTimePickerBottomSheetState();
}

class _DateTimePickerBottomSheetState extends State<DateTimePickerBottomSheet> {
  late DateTime _selectedDate = widget.initialDate ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return BottomSheetScreen(
      closeButtonText: widget.backText,
      title: widget.title,
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: AppCupertinoDatePicker(
              onSelectedItemChanged: (value) => _selectedDate = value,
              selectedDate: _selectedDate,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
            ),
          ),
          const SizedBox(height: 16),
          AppBaseButton.elevated(
            theme: theme,
            onPressed: widget.onDateSelected == null
                ? () => Navigator.pop(context, _selectedDate)
                : () => widget.onDateSelected!(context, _selectedDate),
            text: widget.confirmText,
          ),
        ],
      ),
    );
  }
}
