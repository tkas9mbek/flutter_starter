import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? theme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primary : theme.border,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: textStyles.regularBody12.copyWith(
                color: isSelected ? Colors.white : theme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: textStyles.boldBody16.copyWith(
                color: isSelected ? Colors.white : theme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
