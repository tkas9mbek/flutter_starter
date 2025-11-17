import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_date_picker.dart'
    as custom;
import 'package:starter/features/task/ui/calendar/widget/tasks_timeline.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(getIt<TaskRepository>())
        ..add(CalendarEvent.dateSelected(DateTime.now())),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(
        title: 'Календарь',
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) => Column(
          children: [
            custom.CalendarDatePicker(selectedDate: state.selectedDate),
            Expanded(
              child: state.when(
                initial: () => EmptyInformationBody(
                  text: Localizer.of(context).selectDate,
                ),
                loading: (date) => const CustomCircularProgressIndicator(),
                success: (date, tasks) {
                  if (tasks.isEmpty) {
                    return EmptyInformationBody(
                      text: Localizer.of(context).noTasksForDate,
                    );
                  }

                  return TasksTimeline(tasks: tasks);
                },
                failure: (date, exception) => FailureWidgetLarge(
                  exception: exception,
                  onRetry: () => context.read<CalendarBloc>().add(
                        CalendarEvent.dateSelected(date),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
