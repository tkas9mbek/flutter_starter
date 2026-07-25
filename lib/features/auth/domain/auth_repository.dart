import 'package:rxdart/rxdart.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_status.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';
class AuthRepository {
  AuthRepository(
    this._repositoryExecutor,
    this._authorizedDataSource,
    this._unauthorizedDataSource,
    this._localDataSource,
  );

  final RepositoryExecutor _repositoryExecutor;
  final AuthAuthorizedDataSource _authorizedDataSource;
  final AuthUnauthorizedDataSource _unauthorizedDataSource;
  final AuthLocalDataSource _localDataSource;

  final _controller = BehaviorSubject<AuthStatus>();

  ValueStream<AuthStatus> get status => _controller.stream;

  /// Clears secure storage on first launch. Returns whether the app
  /// had been launched before.
  Future<bool> clearIfNotLaunchedBefore() => _repositoryExecutor.execute(
    _localDataSource.clearIfNotLaunchedBefore,
  );

  Future<bool> hasToken() => _repositoryExecutor.execute(() async {
    final token = await _localDataSource.getToken();

    return token != null;
  });

  Future<void> logout() async {
    _controller.add(AuthStatus.unauthenticated);

    final token = await _localDataSource.getToken();

    if (token == null) {
      return _localDataSource.clearStorage();
    }

    await _repositoryExecutor.execute(() async {
      await _authorizedDataSource.logout();
      await _localDataSource.clearStorage();
    });
  }

  Future<void> login({required String phone, required String password}) async {
    final body = AuthLoginRequestBody(phone: phone, password: password);

    final response = await _repositoryExecutor.execute(
      () => _unauthorizedDataSource.login(body),
    );

    await _localDataSource.saveToken(response);

    _controller.add(AuthStatus.authenticated);
  }

  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required DateTime birthday,
  }) async {
    final body = AuthRegisterRequestBody(
      name: name,
      phone: phone,
      password: password,
      birthday: birthday,
    );
    final response = await _repositoryExecutor.execute(
      () => _unauthorizedDataSource.register(body),
    );

    await _localDataSource.saveToken(response);

    _controller.add(AuthStatus.authenticated);
  }

  /// Requests a one-time code sent to [phone]. Confirm it with [verifyOtp].
  Future<void> requestOtp({required String phone}) async {
    final body = AuthOtpRequestBody(phone: phone);

    await _repositoryExecutor.execute(
      () => _unauthorizedDataSource.requestOtp(body),
    );
  }

  /// Verifies the code sent to [phone] and authenticates.
  Future<void> verifyOtp({required String phone, required String otp}) async {
    final body = AuthVerifyOtpRequestBody(phone: phone, otp: otp);

    final response = await _repositoryExecutor.execute(
      () => _unauthorizedDataSource.verifyOtp(body),
    );

    await _localDataSource.saveToken(response);

    _controller.add(AuthStatus.authenticated);
  }

  Future<void> dispose() => _controller.close();
}
