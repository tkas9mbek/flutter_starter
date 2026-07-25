import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

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
      const RawRepositoryExecutor().withErrorHandling().withRetry(
        maxRetries: 3,
        retryDelay: const Duration(milliseconds: 10),
      ),
      authorizedDataSource,
      unauthorizedDataSource,
      localDataSource,
    );
    authBloc = AuthBloc(authRepository);
  });

  test(
    'initial state is unknown()',
    () => expect(authBloc.state, const AuthState.unknown()),
  );

  group('on initialized() event', () {
    const event = AuthEvent.initialized();

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when hasToken is true.',
      build: () {
        when(
          () => localDataSource.clearIfNotLaunchedBefore(),
        ).thenAnswer((_) async => true);
        when(
          () => localDataSource.getToken(),
        ).thenAnswer((_) async => AuthMockModels.authToken);

        return authBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const AuthState.authenticated()],
      verify: (_) {
        verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
        verify(() => localDataSource.getToken()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when hasToken is false.',
      build: () {
        when(
          () => localDataSource.clearIfNotLaunchedBefore(),
        ).thenAnswer((_) async => true);
        when(() => localDataSource.getToken()).thenAnswer((_) async => null);

        return authBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const AuthState.unauthenticated()],
      verify: (_) {
        verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
        verify(() => localDataSource.getToken()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] when the token check throws an AppException.',
      build: () {
        when(
          () => localDataSource.clearIfNotLaunchedBefore(),
        ).thenAnswer((_) async => true);
        when(
          () => localDataSource.getToken(),
        ).thenThrow(const DevelopmentException());

        return authBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const AuthState.unauthenticated()],
      verify: (_) {
        verify(() => localDataSource.clearIfNotLaunchedBefore()).called(1);
        verify(() => localDataSource.getToken()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'propagates raw (non-AppException) errors instead of swallowing them.',
      build: () {
        when(
          () => localDataSource.clearIfNotLaunchedBefore(),
        ).thenAnswer((_) async => true);
        when(() => localDataSource.getToken()).thenThrow(Exception('Error'));

        // Constructed here (not reused from the outer setUp) so bloc_test's
        // observer swap is in place before AuthBloc captures Bloc.observer —
        // otherwise `errors:` below never sees anything (the bloc's observer
        // reference would be frozen to whatever was active before this
        // build() ran).
        return AuthBloc(authRepository);
      },
      act: (bloc) => bloc.add(event),
      wait: const Duration(milliseconds: 120),
      expect: () => <AuthState>[],
      errors: () => [isA<Exception>()],
    );
  });

  group('on logoutRequested() event', () {
    const event = AuthEvent.logoutRequested();

    blocTest<AuthBloc, AuthState>(
      'calls logout on AuthRepository.',
      build: () {
        when(
          () => localDataSource.getToken(),
        ).thenAnswer((_) async => AuthMockModels.authToken);
        when(() => localDataSource.clearStorage()).thenAnswer((_) async {});
        when(() => authorizedDataSource.logout()).thenAnswer((_) async {});

        return authBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const AuthState.unauthenticated()],
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
      expect: () => [const AuthState.unauthenticated()],
    );
  });

  group('on signedIn() event', () {
    const event = AuthEvent.signedIn();

    blocTest<AuthBloc, AuthState>(
      'emits [authenticated] state.',
      build: () => authBloc,
      act: (bloc) => bloc.add(event),
      expect: () => [const AuthState.authenticated()],
    );
  });
}
