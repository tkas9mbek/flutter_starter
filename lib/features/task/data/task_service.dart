import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';

part 'task_service.g.dart';

@RestApi()
abstract class TaskService {
  factory TaskService(Dio dio) = _TaskService;

  @GET('/tasks')
  Future<List<Task>> getTasks();

  @GET('/tasks/date/{date}')
  Future<List<Task>> getTasksByDate(@Path('date') String date);

  @POST('/tasks')
  Future<Task> createTask(@Body() TaskCreateRequest request);

  @PUT('/tasks/{id}')
  Future<Task> updateTask(
    @Path('id') String id,
    @Body() TaskCreateRequest request,
  );

  @DELETE('/tasks/{id}')
  Future<void> deleteTask(@Path('id') String id);

  @POST('/tasks/{id}/toggle')
  Future<Task> toggleTaskCompletion(@Path('id') String id);
}
