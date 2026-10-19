import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter/features/task/ui/create/bloc/task_creation_bloc.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

import '../model/task_mock_models.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository repository;

  final form = TaskCreateForm(
    title: 'New Task',
    description: 'New Description',
    date: DateTime(2025, 1, 20),
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 10, minute: 30),
  );
  final expectedRequest = TaskCreateRequest(
    title: 'New Task',
    description: 'New Description',
    date: DateTime(2025, 1, 20),
    startTime: DateTime(2025, 1, 20, 9, 0),
    endTime: DateTime(2025, 1, 20, 10, 30),
  );

  setUpAll(() => registerFallbackValue(expectedRequest));

  setUp(() => repository = MockTaskRepository());

  test(
    'initial state is initial()',
    () => expect(
      TaskCreationBloc(repository).state,
      const TaskCreationState.initial(),
    ),
  );

  group('on submitted() event', () {
    blocTest<TaskCreationBloc, TaskCreationState>(
      'emits [loading, success] and sends the form merged into a request',
      build: () {
        when(
          () => repository.createTask(any()),
        ).thenAnswer((_) async => TaskMockModels.task3);

        return TaskCreationBloc(repository);
      },
      act: (bloc) => bloc.add(TaskCreationEvent.submitted(form)),
      expect: () => [
        const TaskCreationState.loading(),
        TaskCreationState.success(TaskMockModels.task3),
      ],
      verify: (_) => expect(
        verify(() => repository.createTask(captureAny())).captured.single,
        expectedRequest,
      ),
    );

    blocTest<TaskCreationBloc, TaskCreationState>(
      'emits [loading, failure] when creation throws',
      build: () {
        when(
          () => repository.createTask(any()),
        ).thenThrow(const ServerException(statusCode: 500));

        return TaskCreationBloc(repository);
      },
      act: (bloc) => bloc.add(TaskCreationEvent.submitted(form)),
      expect: () => [
        const TaskCreationState.loading(),
        isA<FailureTaskCreationState>().having(
          (state) => state.exception,
          'exception',
          isA<ServerException>(),
        ),
      ],
    );
  });
}
