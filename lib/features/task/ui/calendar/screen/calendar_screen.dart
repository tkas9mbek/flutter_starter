import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_horizontal_date_picker.dart';
import 'package:starter/features/task/ui/calendar/widget/calendar_status_body.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/screen/multi_bloc_refresh_indicator.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<CalendarBloc>()
                ..add(CalendarEvent.dateSelected(DateTime.now())),
        ),
        BlocProvider(create: (context) => getIt<TaskDeleteBloc>()),
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
        if (state is SuccessTaskDeleteState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(
              text: localizer.taskDeletedSuccessfully,
            ),
          );
          context.read<CalendarBloc>().add(const CalendarEvent.refreshed());
        }

        if (state is FailureTaskDeleteState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.error(text: localizer.failedToDeleteTask),
          );
        }
      },
      child: Scaffold(
        appBar: TitleAppBar(title: localizer.calendar),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) => Column(
            children: [
              CalendarHorizontalDatePicker(selectedDate: state.selectedDate),
              Expanded(
                child: MultiBlocRefreshIndicator(
                  blocs: [context.read<CalendarBloc>()],
                  onRefresh: () async => context.read<CalendarBloc>().add(
                    const CalendarEvent.refreshed(),
                  ),
                  child: CalendarStatusBody(status: state.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
