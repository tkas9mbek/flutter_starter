import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter_toolkit/data/repository_executor/retriable_repository_executor.dart';

import '../model/auth_mock_models.dart';

class MockAuthorizedDataSource extends Mock
    implements AuthAuthorizedDataSource {}

class MockUnauthorizedDataSource extends Mock
    implements AuthUnauthorizedDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthBloc authBloc;
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
    authBloc = AuthBloc(authRepository);
  });

  test('initial state is unknown()', () {
    expect(authBloc.state, const AuthState.unknown());
  });

  group(
    'on initialized() event',
    () {
      const event = AuthEvent.initialized();

      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when hasToken is true.',
        build: () {
          when(() => localDataSource.clearIfNotLaunchedBefore())
              .thenAnswer((_) async {});
          when(() => localDataSource.getToken())
              .thenAnswer((_) async => AuthMockModels.authToken);
          return authBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const AuthState.authenticated(),
        ],
        verify: (_) {
          verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
          verify(() => localDataSource.getToken()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when hasToken is false.',
        build: () {
          when(() => localDataSource.clearIfNotLaunchedBefore())
              .thenAnswer((_) async {});
          when(() => localDataSource.getToken()).thenAnswer((_) async => null);
          return authBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
          verify(() => localDataSource.getToken()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when hasToken throws an exception.',
        build: () {
          when(() => localDataSource.clearIfNotLaunchedBefore())
              .thenAnswer((_) async {});
          when(() => localDataSource.getToken()).thenThrow(Exception('Error'));
          return authBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
          verify(() => localDataSource.getToken()).called(1);
        },
      );
    },
  );

  group('on logoutRequested() event', () {
    const event = AuthEvent.logoutRequested();

    blocTest<AuthBloc, AuthState>(
      'calls logout on AuthRepository.',
      build: () {
        when(() => localDataSource.clearStorage()).thenAnswer((_) async {});
        when(() => authorizedDataSource.logout()).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => localDataSource.clearStorage()).called(1);
        verify(() => authorizedDataSource.logout()).called(1);
      },
    );
  });

  group('on loggedOut() event', () {
    const event = AuthEvent.loggedOut();

    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] state.',
      build: () => authBloc,
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AuthState.unauthenticated(),
      ],
    );
  });

  group('on signedIn() event', () {
    const event = AuthEvent.signedIn();

    blocTest<AuthBloc, AuthState>(
      'emits [authenticated] state.',
      build: () => authBloc,
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AuthState.authenticated(),
      ],
    );
  });
}
