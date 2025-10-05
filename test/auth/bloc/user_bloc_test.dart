import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/application/root/bloc/user_bloc.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter_toolkit/data/exceptions/auth_exception.dart';
import 'package:starter_toolkit/data/repository_executor/retriable_repository_executor.dart';

import '../model/auth_mock_models.dart';

class MockAuthorizedDataSource extends Mock
    implements AuthAuthorizedDataSource {}

class MockUnauthorizedDataSource extends Mock
    implements AuthUnauthorizedDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late UserBloc userBloc;
  late MockAuthorizedDataSource authorizedDataSource;
  late MockUnauthorizedDataSource unauthorizedDataSource;
  late MockLocalDataSource localDataSource;
  late AuthRepository authRepository;

  setUp(() {
    authorizedDataSource = MockAuthorizedDataSource();
    unauthorizedDataSource = MockUnauthorizedDataSource();
    localDataSource = MockLocalDataSource();
    authRepository = AuthRepository(
      const RetriableRepositoryExecutor(),
      authorizedDataSource,
      unauthorizedDataSource,
      localDataSource,
    );
    userBloc = UserBloc(authRepository);
  });

  test('initial state is initial()', () {
    expect(userBloc.state, const UserState.initial());
  });

  group(
    'on requested() event',
    () {
      const event = UserEvent.requested();
      final user = AuthMockModels.user;

      blocTest<UserBloc, UserState>(
        'emits [success] when getUserProfile is successful.',
        build: () {
          when(() => authorizedDataSource.getUserProfile())
              .thenAnswer((_) async => user);
          return userBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          UserState.success(user: user),
        ],
        verify: (_) {
          verify(() => authorizedDataSource.getUserProfile()).called(1);
        },
      );

      const exception = AuthException('Auth failed');

      blocTest<UserBloc, UserState>(
        'emits [failure] when getUserProfile throws an exception.',
        build: () {
          when(() => authorizedDataSource.getUserProfile())
              .thenThrow(exception);
          return userBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const UserState.failure(exception),
        ],
        verify: (_) {
          verify(() => authorizedDataSource.getUserProfile()).called(1);
        },
      );
    },
  );

  group('state helper methods', () {
    const initialState = UserState.initial();
    const failureState = UserState.failure(AuthException('Auth failed'));
    final successState = UserState.success(user: AuthMockModels.user);

    test('user returns user for success state', () {
      userBloc.emit(successState);
      expect(userBloc.state.user, AuthMockModels.user);
    });

    test('user returns null for other states', () {
      userBloc.emit(initialState);
      expect(userBloc.state.user, isNull);

      userBloc.emit(failureState);
      expect(userBloc.state.user, isNull);
    });
  });
}
