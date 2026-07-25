import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';

/// A bottom sheet that allows the user to select a time of day, matching
/// [DateTimePickerBottomSheet] in shape. Pops with the selected [TimeOfDay].
class TimePickerBottomSheet extends StatefulWidget {
  const TimePickerBottomSheet({
    required this.title,
    required this.backText,
    required this.confirmText,
    this.initialTime,
    super.key,
  });

  final String title;
  final String backText;
  final String confirmText;
  final TimeOfDay? initialTime;

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late TimeOfDay _selectedTime = widget.initialTime ?? TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return BottomSheetScreen(
      closeButtonText: widget.backText,
      title: widget.title,
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: textStyles.mediumTitle18,
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: MediaQuery.alwaysUse24HourFormatOf(context),
                initialDateTime: DateTime(
                  2000,
                  1,
                  1,
                  _selectedTime.hour,
                  _selectedTime.minute,
                ),
                onDateTimeChanged: (value) =>
                    _selectedTime = TimeOfDay.fromDateTime(value),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppElevatedButton.big(
            context: context,
            onPressed: () => Navigator.pop(context, _selectedTime),
            text: widget.confirmText,
          ),
        ],
      ),
    );
  }
}
