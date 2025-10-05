import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter_toolkit/data/exceptions/auth_exception.dart';
import 'package:starter_toolkit/data/repository_executor/retriable_repository_executor.dart';

import '../model/auth_mock_models.dart';

class FakeAuthToken extends Fake implements AuthToken {}

class MockAuthorizedDataSource extends Mock
    implements AuthAuthorizedDataSource {}

class MockUnauthorizedDataSource extends Mock
    implements AuthUnauthorizedDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthToken());
  });

  late LoginBloc loginBloc;
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
    loginBloc = LoginBloc(authRepository);
  });

  test('initial state is initial()', () {
    expect(loginBloc.state, const LoginState.initial());
  });

  group(
    'on submitted() event',
    () {
      const form = LoginForm(
        phone: '+79991234567',
        password: 'password',
      );
      const event = LoginEvent.submitted(form);
      const exception = AuthException('Auth failed');
      final requestBody = AuthLoginRequestBody(
        phone: form.phone,
        password: form.password,
      );
      final authToken = AuthMockModels.authToken;

      blocTest<LoginBloc, LoginState>(
        'emits [loading, success] when login is successful',
        setUp: () {
          registerFallbackValue(requestBody);
          registerFallbackValue(authToken);
        },
        build: () {
          when(() => unauthorizedDataSource.login(requestBody))
              .thenAnswer((_) async => authToken);
          when(() => localDataSource.saveToken(authToken))
              .thenAnswer((_) async {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const LoginState.loading(),
          const LoginState.success(),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.login(requestBody)).called(1);
          verify(() => localDataSource.saveToken(authToken)).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] when login fails',
        build: () {
          when(() => unauthorizedDataSource.login(requestBody))
              .thenThrow(exception);

          return loginBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const LoginState.loading(),
          const LoginState.failure(exception),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.login(requestBody)).called(1);
          verifyNever(() => localDataSource.saveToken(any()));
        },
      );

      blocTest(
        'emits [loading, failure] when saveToken fails',
        build: () {
          when(() => unauthorizedDataSource.login(requestBody))
              .thenAnswer((_) async => authToken);
          when(() => localDataSource.saveToken(authToken)).thenThrow(exception);

          return loginBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const LoginState.loading(),
          const LoginState.failure(exception),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.login(requestBody)).called(1);
          verify(() => localDataSource.saveToken(authToken)).called(1);
        },
      );
    },
  );

  group('state helper methods', () {
    const initialState = LoginState.initial();
    const successState = LoginState.success();
    const loadingState = LoginState.loading();
    const failureState = LoginState.failure(AuthException('Auth failed'));

    test('isLoading returns true for loading state', () {
      loginBloc.emit(loadingState);
      expect(loginBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading states', () {
      loginBloc.emit(initialState);
      expect(loginBloc.state.isLoading, isFalse);

      loginBloc.emit(successState);
      expect(loginBloc.state.isLoading, isFalse);

      loginBloc.emit(failureState);
      expect(loginBloc.state.isLoading, isFalse);
    });
  });
}
