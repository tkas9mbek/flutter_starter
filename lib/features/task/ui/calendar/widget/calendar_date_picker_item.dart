import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';

class CalendarDatePickerItem extends StatelessWidget {
  const CalendarDatePickerItem({
    required this.date,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final isMarkedToday = date.isToday && !isSelected;

    final weekdayColor = isSelected ? theme.onPrimary : theme.textSecondary;
    final dayColor = switch ((isSelected, isMarkedToday)) {
      (true, _) => theme.onPrimary,
      (_, true) => theme.accent,
      _ => theme.textSecondary,
    };

    return AppTapArea(
      onTap: onTap,
      selected: isSelected,
      child: Container(
        width: 56,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? theme.primary : null,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: isMarkedToday ? Border.all(color: theme.accent) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: textStyles.regularBody12.copyWith(color: weekdayColor),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: textStyles.mediumBody16.copyWith(color: dayColor),
            ),
          ],
        ),
      ),
    );
  }
}
