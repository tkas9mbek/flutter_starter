import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/dialogs/app_cupertino_date_picker.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';

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
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _getValidInitialDate();
  }

  DateTime _getValidInitialDate() {
    if (widget.initialDate != null) {
      return widget.initialDate!;
    }

    final now = DateTime.now();
    final minDate = widget.minDate;
    final maxDate = widget.maxDate;

    if (minDate != null && now.isBefore(minDate)) {
      return minDate;
    }

    if (maxDate != null && now.isAfter(maxDate)) {
      return maxDate;
    }

    return now;
  }

  @override
  Widget build(BuildContext context) {
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
          AppElevatedButton.big(
            context: context,
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
