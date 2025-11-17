import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/starter_uikit.dart';

class CalendarDatePicker extends StatelessWidget {
  const CalendarDatePicker({
    required this.selectedDate,
    super.key,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    final dates = List.generate(7, (index) {
      return selectedDate.add(Duration(days: index - 3));
    });

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.isSameDay(selectedDate);

          return DatePickerItem(
            date: date,
            isSelected: isSelected,
            onTap: () => context.read<CalendarBloc>().add(
                  CalendarEvent.dateSelected(date),
                ),
          );
        },
      ),
    );
  }
}

class DatePickerItem extends StatelessWidget {
  const DatePickerItem({
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
