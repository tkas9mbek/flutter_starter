import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_date_picker_item.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class CalendarHorizontalDatePicker extends StatelessWidget {
  const CalendarHorizontalDatePicker({
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

          return CalendarDatePickerItem(
            date: date,
            isSelected: isSelected,
            onTap: () => context
                .read<CalendarBloc>()
                .add(CalendarEvent.dateSelected(date)),
          );
        },
      ),
    );
  }
}
