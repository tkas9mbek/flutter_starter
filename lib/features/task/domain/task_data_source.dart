import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';

abstract class TaskDataSource {
  Future<List<Task>> getTasks();

  Future<List<Task>> getTasksByDate(DateTime date);

  Future<PaginatedListItems<Task>> searchTasks(String query, {required int page});

  Future<Task> createTask(TaskCreateRequest request);

  Future<Task> updateTask(String id, TaskCreateRequest request);

  Future<void> deleteTask(String id);
}
