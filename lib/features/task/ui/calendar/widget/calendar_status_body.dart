import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_loading_skeleton.dart';
import 'package:starter/features/task/ui/calendar/widget/tasks_timeline_list.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/size/fill_remaining_scroll_view.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

/// Maps the calendar's load status to the matching body view: date prompt,
/// loading skeleton, timeline, empty state, or failure with retry.
class CalendarStatusBody extends StatelessWidget {
  const CalendarStatusBody({required this.status, super.key});

  final CalendarStatus status;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return switch (status) {
      InitialCalendarStatus() => FillRemainingScrollView(
        child: EmptyInformationBody(text: localizer.selectDate),
      ),
      LoadingCalendarStatus() => const CalendarLoadingSkeleton(),
      SuccessCalendarStatus(:final tasks) =>
        tasks.isEmpty
            ? FillRemainingScrollView(
                child: EmptyInformationBody(text: localizer.noTasksForDate),
              )
            : TasksTimelineList(tasks: tasks),
      FailureCalendarStatus(:final exception) => FillRemainingScrollView(
        child: FailureWidget.large(
          exception: exception,
          onRetry: () =>
              context.read<CalendarBloc>().add(const CalendarEvent.refreshed()),
        ),
      ),
    };
  }
}
