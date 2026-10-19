import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_date_picker_item.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

class CalendarHorizontalDatePicker extends StatelessWidget {
  const CalendarHorizontalDatePicker({required this.selectedDate, super.key});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(
      7,
      (index) => selectedDate.add(Duration(days: index - 3)),
    );

    return Column(
      children: [
        SizedBox(
          height: 92,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = date.isSameDay(selectedDate);

              return CalendarDatePickerItem(
                date: date,
                isSelected: isSelected,
                onTap: () => context.read<CalendarBloc>().add(
                  CalendarEvent.dateSelected(date),
                ),
              );
            },
          ),
        ),
        const ThinHorizontalDivider(),
      ],
    );
  }
}
