import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_horizontal_date_picker.dart';
import 'package:starter/features/task/ui/calendar/widget/tasks_timeline_list.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc(getIt<TaskRepository>())
            ..add(CalendarEvent.dateSelected(DateTime.now())),
        ),
        BlocProvider(
          create: (context) => TaskDeleteBloc(getIt<TaskRepository>()),
        ),
      ],
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView();

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocListener<TaskDeleteBloc, TaskDeleteState>(
      listener: (context, state) {
        state.mapOrNull(
          success: (_) {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: true,
              message: localizer.taskDeletedSuccessfully,
            );
            context.read<CalendarBloc>().add(
                  const CalendarEvent.refreshed(),
                );
          },
          failure: (failureState) {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: false,
              message: localizer.failedToDeleteTask,
            );
          },
        );
      },
      child: Scaffold(
        appBar: TitleAppBar(title: localizer.calendar),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) => Column(
            children: [
              CalendarHorizontalDatePicker(selectedDate: state.selectedDate),
              Expanded(
                child: state.status.when(
                  initial: () => EmptyInformationBody(
                    text: localizer.selectDate,
                  ),
                  loading: () => const CustomCircularProgressIndicator(),
                  success: (tasks) {
                    if (tasks.isEmpty) {
                      return EmptyInformationBody(
                        text: localizer.noTasksForDate,
                      );
                    }

                    return TasksTimelineList(tasks: tasks);
                  },
                  failure: (exception) => FailureWidgetLarge(
                    exception: exception,
                    onRetry: () => context.read<CalendarBloc>().add(
                          const CalendarEvent.refreshed(),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
