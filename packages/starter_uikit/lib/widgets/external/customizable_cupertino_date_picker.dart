import 'package:flutter/cupertino.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';

/// A fully customizable day/month/year wheel picker built from three
/// [CupertinoPicker]s, clamping selection to [minDate]/[maxDate] (defaulting
/// to +/-100 years), handling month lengths and leap years, and styling
/// selected, unselected, and disabled items independently.
class CustomizableCupertinoDatePicker extends StatefulWidget {
  const CustomizableCupertinoDatePicker({
    required this.itemExtent,
    required this.onSelectedItemChanged,
    this.squeeze = 1.45,
    this.diameterRatio = 1.1,
    this.magnification = 1.0,
    this.offAxisFraction = 0.0,
    this.useMaginifier = false,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
    this.minDate,
    this.maxDate,
    this.selectedDate,
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.backgroundColor,
    super.key,
  });

  final double itemExtent;
  final Widget selectionOverlay;
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMaginifier;
  final double magnification;
  final double squeeze;
  final void Function(DateTime) onSelectedItemChanged;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final TextStyle? disabledStyle;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? selectedDate;

  @override
  State<CustomizableCupertinoDatePicker> createState() =>
      _CustomizableCupertinoDatePickerState();
}

class _CustomizableCupertinoDatePickerState
    extends State<CustomizableCupertinoDatePicker> {
  late DateTime _minDate;
  late DateTime _maxDate;
  late DateTime _selectedDate;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _yearScrollController;

  @override
  void initState() {
    super.initState();
    _validateDates();
    _initDates();

    _dayScrollController = FixedExtentScrollController(
      initialItem: _selectedDayIndex,
    );
    _monthScrollController = FixedExtentScrollController(
      initialItem: _selectedMonthIndex,
    );
    _yearScrollController = FixedExtentScrollController(
      initialItem: _selectedYearIndex,
    );
  }

  void _validateDates() {
    if (widget.minDate != null && widget.maxDate != null) {
      assert(!widget.minDate!.isAfter(widget.maxDate!), 'minDate > maxDate');
    }
    if (widget.minDate != null && widget.selectedDate != null) {
      assert(
        !widget.minDate!.isAfter(widget.selectedDate!),
        'minDate > selectedDate',
      );
    }
    if (widget.maxDate != null && widget.selectedDate != null) {
      assert(
        !widget.selectedDate!.isAfter(widget.maxDate!),
        'selectedDate > maxDate',
      );
    }
  }

  void _initDates() {
    final currentDate = DateTime.now();
    final minDate = widget.minDate ?? DateTime(currentDate.year - 100);
    final maxDate = widget.maxDate ?? DateTime(currentDate.year + 100);
    // compare calendar days only, so bounds carrying a time-of-day
    // (e.g. DateTime.now()) don't exclude their own day
    _minDate = DateTime(minDate.year, minDate.month, minDate.day);
    _maxDate = DateTime(maxDate.year, maxDate.month, maxDate.day);
    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    } else if (!currentDate.isBefore(_minDate) &&
        !currentDate.isAfter(_maxDate)) {
      _selectedDate = currentDate;
    } else {
      _selectedDate = currentDate.isBefore(_minDate) ? _minDate : _maxDate;
    }
    _selectedDayIndex = _selectedDate.day - 1;
    _selectedMonthIndex = _selectedDate.month - 1;
    _selectedYearIndex = _selectedDate.year - _minDate.year;
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  int _numberOfDays() =>
      _daysInMonth(_minDate.year + _selectedYearIndex, _selectedMonthIndex + 1);

  /// date produced by moving the [type] wheel to [index], with the day
  /// clamped to the target month's length so it never rolls over
  DateTime _dateFor(int index, _SelectorType type) {
    final year =
        _minDate.year +
        (type == _SelectorType.year ? index : _selectedYearIndex);
    final month =
        (type == _SelectorType.month ? index : _selectedMonthIndex) + 1;
    final day = (type == _SelectorType.day ? index : _selectedDayIndex) + 1;
    final dayCount = _daysInMonth(year, month);

    return DateTime(year, month, day > dayCount ? dayCount : day);
  }

  void _onSelectedItemChanged(int index, _SelectorType type) {
    final temp = _dateFor(index, type);

    // return if selected date is not the min - max date range
    // scroll selector back to the valid point
    if (temp.isBefore(_minDate) || temp.isAfter(_maxDate)) {
      switch (type) {
        case _SelectorType.day:
          _dayScrollController.jumpToItem(_selectedDayIndex);
        case _SelectorType.month:
          _monthScrollController.jumpToItem(_selectedMonthIndex);
        case _SelectorType.year:
          _yearScrollController.jumpToItem(_selectedYearIndex);
      }

      return;
    }

    _selectedDate = temp;
    final previousDayIndex = _selectedDayIndex;

    switch (type) {
      case _SelectorType.day:
        break;
      case _SelectorType.month:
        _selectedMonthIndex = index;
      case _SelectorType.year:
        _selectedYearIndex = index;
    }
    _selectedDayIndex = temp.day - 1;

    // keep the day wheel in sync when the day was clamped by a
    // month/year change (e.g. Jan 31 -> Feb 28)
    if (type != _SelectorType.day && _selectedDayIndex != previousDayIndex) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _dayScrollController.jumpToItem(_selectedDayIndex),
      );
    }

    setState(() {});
    widget.onSelectedItemChanged(_selectedDate);
  }

  bool _isDisabled(int index, _SelectorType type) {
    final temp = _dateFor(index, type);

    return temp.isAfter(_maxDate) || temp.isBefore(_minDate);
  }

  Widget _selector({
    required List<dynamic> values,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
    required void Function(int) onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker.builder(
      childCount: values.length,
      squeeze: widget.squeeze,
      itemExtent: widget.itemExtent,
      scrollController: scrollController,
      useMagnifier: widget.useMaginifier,
      diameterRatio: widget.diameterRatio,
      magnification: widget.magnification,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction,
      selectionOverlay: widget.selectionOverlay,
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (context, index) => Container(
        height: widget.itemExtent,
        alignment: Alignment.center,
        child: Text(
          '${values[index]}',
          style: _itemStyle(
            index: index,
            selectedValueIndex: selectedValueIndex,
            isDisabled: isDisabled,
          ),
        ),
      ),
    );
  }

  TextStyle? _itemStyle({
    required int index,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
  }) {
    if (index == selectedValueIndex) {
      return widget.selectedStyle;
    }

    if (isDisabled(index)) {
      return widget.disabledStyle;
    }

    return widget.unselectedStyle;
  }

  Widget _daySelector() {
    return _selector(
      values: List.generate(_numberOfDays(), (index) => index + 1),
      selectedValueIndex: _selectedDayIndex,
      scrollController: _dayScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.day),
      onSelectedItemChanged: (v) =>
          _onSelectedItemChanged(v, _SelectorType.day),
    );
  }

  Widget _monthSelector() {
    final months = [
      UikitLocalizer.of(context).monthJanuary,
      UikitLocalizer.of(context).monthFebruary,
      UikitLocalizer.of(context).monthMarch,
      UikitLocalizer.of(context).monthApril,
      UikitLocalizer.of(context).monthMay,
      UikitLocalizer.of(context).monthJune,
      UikitLocalizer.of(context).monthJuly,
      UikitLocalizer.of(context).monthAugust,
      UikitLocalizer.of(context).monthSeptember,
      UikitLocalizer.of(context).monthOctober,
      UikitLocalizer.of(context).monthNovember,
      UikitLocalizer.of(context).monthDecember,
    ];

    return _selector(
      values: months,
      selectedValueIndex: _selectedMonthIndex,
      scrollController: _monthScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.month),
      onSelectedItemChanged: (v) =>
          _onSelectedItemChanged(v, _SelectorType.month),
    );
  }

  Widget _yearSelector() {
    return _selector(
      values: List.generate(
        _maxDate.year - _minDate.year + 1,
        (index) => _minDate.year + index,
      ),
      selectedValueIndex: _selectedYearIndex,
      scrollController: _yearScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.year),
      onSelectedItemChanged: (v) =>
          _onSelectedItemChanged(v, _SelectorType.year),
    );
  }

  @override
  void dispose() {
    _dayScrollController.dispose();
    _monthScrollController.dispose();
    _yearScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _daySelector()),
        Expanded(flex: 5, child: _monthSelector()),
        Expanded(flex: 3, child: _yearSelector()),
      ],
    );
  }
}

enum _SelectorType { day, month, year }
