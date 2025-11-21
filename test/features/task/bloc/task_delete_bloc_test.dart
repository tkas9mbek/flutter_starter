import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskDeleteBloc taskDeleteBloc;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskDeleteBloc = TaskDeleteBloc(mockTaskRepository);
  });

  test('initial state is initial()', () {
    expect(taskDeleteBloc.state, const TaskDeleteState.initial());
  });

  group('on deleted() event', () {
    const taskId = 'task-123';
    const event = TaskDeleteEvent.deleted(taskId);
    const exception = ServerException(statusCode: 500);

    blocTest<TaskDeleteBloc, TaskDeleteState>(
      'emits [loading, success] when delete is successful',
      build: () {
        when(() => mockTaskRepository.deleteTask(taskId))
            .thenAnswer((_) async {});

        return taskDeleteBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const TaskDeleteState.loading(),
        const TaskDeleteState.success(),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
      },
    );

    blocTest<TaskDeleteBloc, TaskDeleteState>(
      'emits [loading, failure] when delete fails',
      build: () {
        when(() => mockTaskRepository.deleteTask(taskId)).thenThrow(exception);

        return taskDeleteBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const TaskDeleteState.loading(),
        const TaskDeleteState.failure(exception),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
      },
    );

    blocTest<TaskDeleteBloc, TaskDeleteState>(
      'emits [loading, failure] with NoInternetException',
      build: () {
        when(() => mockTaskRepository.deleteTask(taskId))
            .thenThrow(const NoInternetException());

        return taskDeleteBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const TaskDeleteState.loading(),
        const TaskDeleteState.failure(NoInternetException()),
      ],
    );

    blocTest<TaskDeleteBloc, TaskDeleteState>(
      'emits [loading, failure] with ForbiddenException',
      build: () {
        when(() => mockTaskRepository.deleteTask(taskId))
            .thenThrow(const ForbiddenException());

        return taskDeleteBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const TaskDeleteState.loading(),
        const TaskDeleteState.failure(ForbiddenException()),
      ],
    );
  });

  group('state helper methods', () {
    const initialState = TaskDeleteState.initial();
    const successState = TaskDeleteState.success();
    const loadingState = TaskDeleteState.loading();
    const failureState =
        TaskDeleteState.failure(ServerException(statusCode: 500));

    test('isLoading returns true for loading state', () {
      taskDeleteBloc.emit(loadingState);
      expect(taskDeleteBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading states', () {
      taskDeleteBloc.emit(initialState);
      expect(taskDeleteBloc.state.isLoading, isFalse);

      taskDeleteBloc.emit(successState);
      expect(taskDeleteBloc.state.isLoading, isFalse);

      taskDeleteBloc.emit(failureState);
      expect(taskDeleteBloc.state.isLoading, isFalse);
    });
  });
}
