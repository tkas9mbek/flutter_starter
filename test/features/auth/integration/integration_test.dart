import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/auth/data/mock_auth_authorized_data_source.dart';
import 'package:starter/features/auth/data/mock_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_status.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

/// Feature-flow tests: real bloc → real [AuthRepository] → the `Mock*DataSource`
/// implementations that ship behind `useMock`. Only the local data source is
/// substituted — the shipping one talks to the platform keychain, which is
/// unavailable in a unit test.
class _InMemoryAuthLocalDataSource implements AuthLocalDataSource {
  AuthToken? _token;
  bool _launchedBefore = false;

  @override
  Future<void> clearStorage() async => _token = null;

  @override
  Future<void> saveToken(AuthToken token) async => _token = token;

  @override
  Future<bool> clearIfNotLaunchedBefore() async {
    final launchedBefore = _launchedBefore;

    if (!launchedBefore) {
      _launchedBefore = true;
      _token = null;
    }

    return launchedBefore;
  }

  @override
  Future<AuthToken?> getToken() async => _token;
}

class _ThrowingAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  const _ThrowingAuthUnauthorizedDataSource();

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) async =>
      throw const NoInternetException();

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) async =>
      throw const NoInternetException();

  @override
  Future<void> requestOtp(AuthOtpRequestBody body) async =>
      throw const NoInternetException();

  @override
  Future<AuthToken> verifyOtp(AuthVerifyOtpRequestBody body) async =>
      throw const NoInternetException();
}

const _loginForm = LoginForm(phone: '+79991234567', password: 'password123');

final _registrationForm = RegistrationForm(
  name: 'Test User',
  phone: '+79991234567',
  password: 'password123',
  birthday: DateTime(1990),
);

void main() {
  late _InMemoryAuthLocalDataSource localDataSource;

  setUp(() => localDataSource = _InMemoryAuthLocalDataSource());

  AuthRepository buildRepository([
    AuthUnauthorizedDataSource unauthorizedDataSource =
        const MockAuthUnauthorizedDataSource(),
  ]) {
    final repository = AuthRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      const MockAuthAuthorizedDataSource(),
      unauthorizedDataSource,
      localDataSource,
    );
    addTearDown(repository.dispose);

    return repository;
  }

  group('login flow', () {
    LoginBloc buildBloc([
      AuthUnauthorizedDataSource unauthorizedDataSource =
          const MockAuthUnauthorizedDataSource(),
    ]) {
      final bloc = LoginBloc(buildRepository(unauthorizedDataSource));
      addTearDown(bloc.close);

      return bloc;
    }

    test('reaches success, stores the token and authenticates', () async {
      final bloc = buildBloc();

      bloc.add(const LoginEvent.submitted(_loginForm));
      await bloc.stream.firstWhere(
        (state) => state is SuccessLoginState || state is FailureLoginState,
      );

      expect(bloc.state, isA<SuccessLoginState>());
      expect(await localDataSource.getToken(), isNotNull);
      expect(bloc.authRepository.status.value, AuthStatus.authenticated);
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = buildBloc(const _ThrowingAuthUnauthorizedDataSource());

      bloc.add(const LoginEvent.submitted(_loginForm));
      await bloc.stream.firstWhere(
        (state) => state is SuccessLoginState || state is FailureLoginState,
      );

      expect(bloc.state, isA<FailureLoginState>());
      expect(await localDataSource.getToken(), isNull);
    });
  });

  group('registration flow', () {
    RegistrationBloc buildBloc([
      AuthUnauthorizedDataSource unauthorizedDataSource =
          const MockAuthUnauthorizedDataSource(),
    ]) {
      final bloc = RegistrationBloc(buildRepository(unauthorizedDataSource));
      addTearDown(bloc.close);

      return bloc;
    }

    test('reaches success and stores the token', () async {
      final bloc = buildBloc();

      bloc.add(RegistrationEvent.submitted(_registrationForm));
      await bloc.stream.firstWhere(
        (state) =>
            state is SuccessRegistrationState ||
            state is FailureRegistrationState,
      );

      expect(bloc.state, isA<SuccessRegistrationState>());
      expect(await localDataSource.getToken(), isNotNull);
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = buildBloc(const _ThrowingAuthUnauthorizedDataSource());

      bloc.add(RegistrationEvent.submitted(_registrationForm));
      await bloc.stream.firstWhere(
        (state) =>
            state is SuccessRegistrationState ||
            state is FailureRegistrationState,
      );

      expect(bloc.state, isA<FailureRegistrationState>());
      expect(await localDataSource.getToken(), isNull);
    });
  });

  group('otp flow', () {
    OtpBloc buildBloc() {
      final bloc = OtpBloc(buildRepository());
      addTearDown(bloc.close);

      return bloc;
    }

    test('reaches success and stores the token', () async {
      final bloc = buildBloc();

      bloc.add(const OtpEvent.submitted(phone: '+79991234567', otp: '1234'));
      await bloc.stream.firstWhere(
        (state) => state is SuccessOtpState || state is FailureOtpState,
      );

      expect(bloc.state, isA<SuccessOtpState>());
      expect(await localDataSource.getToken(), isNotNull);
    });

    // '0000' is the mock data source's wrong-code fault injection.
    test('surfaces a rejected code end-to-end', () async {
      final bloc = buildBloc();

      bloc.add(const OtpEvent.submitted(phone: '+79991234567', otp: '0000'));
      await bloc.stream.firstWhere(
        (state) => state is SuccessOtpState || state is FailureOtpState,
      );

      expect(bloc.state, isA<FailureOtpState>());
      expect(await localDataSource.getToken(), isNull);
    });
  });
}
