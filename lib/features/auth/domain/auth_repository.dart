import 'package:rxdart/rxdart.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_status.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class AuthRepository {
  final RepositoryExecutor _repositoryExecutor;
  final AuthAuthorizedDataSource _authorizedDataSource;
  final AuthUnauthorizedDataSource _unauthorizedDataSource;
  final AuthLocalDataSource _localDataSource;

  final _controller = BehaviorSubject<AuthStatus>();

  ValueStream<AuthStatus> get status => _controller.stream;

  AuthRepository(
    this._repositoryExecutor,
    this._authorizedDataSource,
    this._unauthorizedDataSource,
    this._localDataSource,
  );

  Future<void> clearIfNotLaunchedBefore() async =>
      _localDataSource.clearIfNotLaunchedBefore();

  Future<bool> hasToken() async {
    final token = await _localDataSource.getToken();

    return token != null;
  }

  Future<void> logout() async {
    _controller.add(AuthStatus.unauthenticated);

    _repositoryExecutor.execute(() async {
      await _authorizedDataSource.logout();
      await _localDataSource.clearStorage();
    });
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    final body = AuthLoginRequestBody(
      phone: phone,
      password: password,
    );

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
}
