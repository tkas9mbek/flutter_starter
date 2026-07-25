import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';

/// A two-step bottom sheet for picking a date range: the user first confirms
/// the start date, then an end date limited to not precede it.
/// Pops with a `(DateTime, DateTime)` record of the selected range.
class DateRangePickerBottomSheet extends StatefulWidget {
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
      initialDate: fromNeedsSelect ? widget.initialDate : _fromDate,
      minDate: fromNeedsSelect ? widget.minDate : _fromDate,
      maxDate: widget.maxDate,
      confirmText: fromNeedsSelect
          ? UikitLocalizer.of(context).next
          : widget.confirmText,
    );
  }
}
