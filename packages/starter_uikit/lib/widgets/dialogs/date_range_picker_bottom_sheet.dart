import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';

class DateRangePickerBottomSheet extends StatefulWidget {
  /// A bottom sheet that allows the user to select a date range.
  /// First, the user selects the start date, then the end date.
  ///
  /// * [backText] is the text of the back button that moves to the first step.
  /// * [confirmText] is the text of the confirm button that moves to the second step.
  const DateRangePickerBottomSheet({
    required this.title,
    required this.backText,
    required this.confirmText,
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

  @override
  State<DateRangePickerBottomSheet> createState() =>
      _DateRangePickerBottomSheetState();
}

class _DateRangePickerBottomSheetState
    extends State<DateRangePickerBottomSheet> {
  DateTime? _fromDate;

  void _onFromDateSelected(DateTime selectedDate) {
    setState(() => _fromDate = selectedDate);
  }

  void _onToDateSelected(BuildContext context, DateTime selectedDate) {
    Navigator.pop(context, (_fromDate!, selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    final fromNeedsSelect = _fromDate == null;

    return DateTimePickerBottomSheet(
      key: ValueKey(_fromDate),
      title: widget.title,
      backText: widget.backText,
      onDateSelected: fromNeedsSelect
          ? (_, date) => _onFromDateSelected(date)
          : _onToDateSelected,
      initialDate: widget.initialDate,
      minDate: fromNeedsSelect ? widget.minDate : _fromDate,
      maxDate: widget.maxDate,
      confirmText:
          fromNeedsSelect ? UikitLocalizer.of(context).next : widget.confirmText,
    );
  }
}
