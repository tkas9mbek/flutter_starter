import 'package:flutter/material.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/calendar/widget/task_timeline_item.dart';

class TasksTimeline extends StatelessWidget {
  const TasksTimeline({
    required this.tasks,
    super.key,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskTimelineItem(task: tasks[index]),
    );
  }
}
