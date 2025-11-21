import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

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

  late RegistrationBloc registrationBloc;
  late MockAuthorizedDataSource authorizedDataSource;
  late MockUnauthorizedDataSource unauthorizedDataSource;
  late MockLocalDataSource localDataSource;
  late AuthRepository authRepository;

  setUp(() {
    authorizedDataSource = MockAuthorizedDataSource();
    unauthorizedDataSource = MockUnauthorizedDataSource();
    localDataSource = MockLocalDataSource();
    authRepository = AuthRepository(
      const RawRepositoryExecutor().withErrorHandling().withRetry(maxRetries: 3),
      authorizedDataSource,
      unauthorizedDataSource,
      localDataSource,
    );
    registrationBloc = RegistrationBloc(authRepository);
  });

  test('initial state is initial()', () {
    expect(registrationBloc.state, const RegistrationState.initial());
  });

  group(
    'on submitted() event',
    () {
      final form = RegistrationForm(
        name: 'Test User',
        phone: '+79991234567',
        password: 'password123',
        birthday: DateTime(1990, 1, 1),
      );
      final event = RegistrationEvent.submitted(form);
      const exception = ServerException(statusCode: 400);
      final requestBody = AuthRegisterRequestBody(
        name: form.name,
        phone: form.phone,
        password: form.password,
        birthday: form.birthday,
      );
      final authToken = AuthMockModels.authToken;

      blocTest<RegistrationBloc, RegistrationState>(
        'emits [loading, success] when registration is successful',
        setUp: () {
          registerFallbackValue(requestBody);
          registerFallbackValue(authToken);
        },
        build: () {
          when(() => unauthorizedDataSource.register(requestBody))
              .thenAnswer((_) async => authToken);
          when(() => localDataSource.saveToken(authToken))
              .thenAnswer((_) async {});

          return registrationBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const RegistrationState.loading(),
          const RegistrationState.success(),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.register(requestBody)).called(1);
          verify(() => localDataSource.saveToken(authToken)).called(1);
        },
      );

      blocTest<RegistrationBloc, RegistrationState>(
        'emits [loading, failure] when registration fails',
        build: () {
          when(() => unauthorizedDataSource.register(requestBody))
              .thenThrow(exception);

          return registrationBloc;
        },
        act: (bloc) => bloc.add(event),
        wait: const Duration(seconds: 15),
        expect: () => [
          const RegistrationState.loading(),
          const RegistrationState.failure(exception),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.register(requestBody)).called(greaterThan(1));
          verifyNever(() => localDataSource.saveToken(any()));
        },
      );

      blocTest(
        'emits [loading, failure] when saveToken fails',
        build: () {
          when(() => unauthorizedDataSource.register(requestBody))
              .thenAnswer((_) async => authToken);
          when(() => localDataSource.saveToken(authToken)).thenThrow(exception);

          return registrationBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const RegistrationState.loading(),
          const RegistrationState.failure(exception),
        ],
        verify: (_) {
          verify(() => unauthorizedDataSource.register(requestBody)).called(1);
          verify(() => localDataSource.saveToken(authToken)).called(1);
        },
      );
    },
  );

  group('state helper methods', () {
    const initialState = RegistrationState.initial();
    const successState = RegistrationState.success();
    const loadingState = RegistrationState.loading();
    const failureState = RegistrationState.failure(ServerException(statusCode: 400));

    test('isLoading returns true for loading state', () {
      registrationBloc.emit(loadingState);
      expect(registrationBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading states', () {
      registrationBloc.emit(initialState);
      expect(registrationBloc.state.isLoading, isFalse);

      registrationBloc.emit(successState);
      expect(registrationBloc.state.isLoading, isFalse);

      registrationBloc.emit(failureState);
      expect(registrationBloc.state.isLoading, isFalse);
    });
  });
}
