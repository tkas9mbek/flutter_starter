import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
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
      appBar: TitleAppBar(
        title: 'Calendar',
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          return Column(
            children: [
              // Date Picker
              _DatePicker(selectedDate: state.selectedDate),

              // Tasks Timeline
              Expanded(
                child: state.when(
                  initial: () => const Center(child: Text('Select a date')),
                  loading: (date) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  success: (date, tasks) {
                    if (tasks.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_available_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text('No tasks for this date'),
                          ],
                        ),
                      );
                    }

                    return _TasksTimeline(tasks: tasks);
                  },
                  failure: (date, exception) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text('Failed to load tasks'),
                        const SizedBox(height: 8),
                        Text(exception.toString()),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => context.read<CalendarBloc>().add(
                                CalendarEvent.dateSelected(date),
                              ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final DateTime selectedDate;

  const _DatePicker({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    // Generate 7 days (3 before, current, 3 after)
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
            color: Colors.black.withOpacity(0.05),
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
          final isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              context.read<CalendarBloc>().add(
                    CalendarEvent.dateSelected(date),
                  );
            },
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
                      color: isSelected ? Colors.white : theme.text,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TasksTimeline extends StatelessWidget {
  final List<Task> tasks;

  const _TasksTimeline({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return _TaskTimelineItem(task: tasks[index]);
      },
    );
  }
}

class _TaskTimelineItem extends StatelessWidget {
  final Task task;

  const _TaskTimelineItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeFormat.format(task.startTime),
                  style: textStyles.mediumBody12.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeFormat.format(task.endTime),
                  style: textStyles.regularBody10.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Timeline Line
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: task.isCompleted ? theme.primary : theme.border,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: theme.border,
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Task Card
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<CalendarBloc>().add(
                      CalendarEvent.taskToggled(task.id),
                    );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: task.isCompleted ? theme.primary : theme.border,
                    width: task.isCompleted ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: task.isCompleted
                                ? textStyles.mediumBody14.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: theme.textSecondary,
                                  )
                                : textStyles.mediumBody14,
                          ),
                        ),
                        if (task.isCompleted)
                          Icon(
                            Icons.check_circle,
                            color: theme.primary,
                            size: 20,
                          ),
                      ],
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        task.description,
                        style: textStyles.regularBody12.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
