import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/data/remote_auth_authorized_data_source.dart';
import 'package:starter/features/auth/data/remote_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/auth_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class FakeAuthToken extends Fake implements AuthToken {}

class FakeAuthLoginRequestBody extends Fake implements AuthLoginRequestBody {}

class FakeAuthRegisterRequestBody extends Fake
    implements AuthRegisterRequestBody {}

AuthToken _fakeFromJson(Map<String, dynamic> json) => AuthToken.fromJson(json);

/// Integration tests: BLoC → AuthRepository → RemoteDataSources → ApiClient (mocked)
/// LocalDataSource is also mocked as it depends on flutter_secure_storage
///
/// Tests the full flow from BLoC through Repository and DataSource with ApiClient mocked.
void main() {
  late MockApiClient mockApiClient;
  late MockAuthLocalDataSource mockLocalDataSource;
  late AuthAuthorizedDataSource authorizedDataSource;
  late AuthUnauthorizedDataSource unauthorizedDataSource;
  late AuthRepository authRepository;

  setUpAll(() {
    registerFallbackValue(HttpMethod.post);
    registerFallbackValue(_fakeFromJson);
    registerFallbackValue(FakeAuthToken());
    registerFallbackValue(FakeAuthLoginRequestBody());
    registerFallbackValue(FakeAuthRegisterRequestBody());
  });

  setUp(() {
    mockApiClient = MockApiClient();
    mockLocalDataSource = MockAuthLocalDataSource();
    authorizedDataSource = RemoteAuthAuthorizedDataSource(mockApiClient);
    unauthorizedDataSource = RemoteAuthUnauthorizedDataSource(mockApiClient);
    authRepository = AuthRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      authorizedDataSource,
      unauthorizedDataSource,
      mockLocalDataSource,
    );
  });

  group('LoginBloc integration', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc(authRepository);
    });

    test('initial state is initial()', () {
      expect(loginBloc.state, const LoginState.initial());
    });

    const loginForm = LoginForm(
      phone: '+79991234567',
      password: 'password123',
    );

    blocTest<LoginBloc, LoginState>(
      'completes full successful flow: BLoC → Repository → DataSource → ApiClient',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => AuthMockModels.authToken);

        when(() => mockLocalDataSource.saveToken(any()))
            .thenAnswer((_) async {});

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitted(loginForm)),
      expect: () => [
        const LoginState.loading(),
        const LoginState.success(),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
        verify(() => mockLocalDataSource.saveToken(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'handles network error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const NoInternetException());

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitted(loginForm)),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure(NoInternetException()),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'handles unauthorized error (401)',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const UnauthorizedException());

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitted(loginForm)),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure(UnauthorizedException()),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'handles saveToken failure',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => AuthMockModels.authToken);

        when(() => mockLocalDataSource.saveToken(any()))
            .thenThrow(const DevelopmentException());

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitted(loginForm)),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure(DevelopmentException()),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/login',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
        verify(() => mockLocalDataSource.saveToken(any())).called(1);
      },
    );
  });

  group('RegistrationBloc integration', () {
    late RegistrationBloc registrationBloc;

    setUp(() {
      registrationBloc = RegistrationBloc(authRepository);
    });

    test('initial state is initial()', () {
      expect(registrationBloc.state, const RegistrationState.initial());
    });

    final registrationForm = RegistrationForm(
      name: 'Test User',
      phone: '+79991234567',
      password: 'password123',
      birthday: DateTime(1990),
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'completes full successful flow: BLoC → Repository → DataSource → ApiClient',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => AuthMockModels.authToken);

        when(() => mockLocalDataSource.saveToken(any()))
            .thenAnswer((_) async {});

        return registrationBloc;
      },
      act: (bloc) => bloc.add(RegistrationEvent.submitted(registrationForm)),
      expect: () => [
        const RegistrationState.loading(),
        const RegistrationState.success(),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
        verify(() => mockLocalDataSource.saveToken(any())).called(1);
      },
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'handles network error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const NoInternetException());

        return registrationBloc;
      },
      act: (bloc) => bloc.add(RegistrationEvent.submitted(registrationForm)),
      expect: () => [
        const RegistrationState.loading(),
        const RegistrationState.failure(NoInternetException()),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'handles validation error (400)',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(
          const ServerException(
            statusCode: 400,
            message: 'Phone already exists',
          ),
        );

        return registrationBloc;
      },
      act: (bloc) => bloc.add(RegistrationEvent.submitted(registrationForm)),
      expect: () => [
        const RegistrationState.loading(),
        const RegistrationState.failure(
          ServerException(
            statusCode: 400,
            message: 'Phone already exists',
          ),
        ),
      ],
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'handles saveToken failure',
      build: () {
        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => AuthMockModels.authToken);

        when(() => mockLocalDataSource.saveToken(any()))
            .thenThrow(const DevelopmentException());

        return registrationBloc;
      },
      act: (bloc) => bloc.add(RegistrationEvent.submitted(registrationForm)),
      expect: () => [
        const RegistrationState.loading(),
        const RegistrationState.failure(DevelopmentException()),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: '/auth/register',
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
        verify(() => mockLocalDataSource.saveToken(any())).called(1);
      },
    );
  });
}
