import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_status.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class MockAuthAuthorizedDataSource extends Mock
    implements AuthAuthorizedDataSource {}

class MockAuthUnauthorizedDataSource extends Mock
    implements AuthUnauthorizedDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepository repository;
  late MockAuthAuthorizedDataSource mockAuthorizedDataSource;
  late MockAuthUnauthorizedDataSource mockUnauthorizedDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(
      AuthLoginRequestBody(phone: '', password: ''),
    );
    registerFallbackValue(
      AuthRegisterRequestBody(
        name: '',
        phone: '',
        password: '',
        birthday: DateTime.now(),
      ),
    );
    registerFallbackValue(
      const AuthToken(accessToken: '', refreshToken: ''),
    );
  });

  setUp(() {
    mockAuthorizedDataSource = MockAuthAuthorizedDataSource();
    mockUnauthorizedDataSource = MockAuthUnauthorizedDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();

    repository = AuthRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      mockAuthorizedDataSource,
      mockUnauthorizedDataSource,
      mockLocalDataSource,
    );
  });

  group('clearIfNotLaunchedBefore', () {
    test('delegates to local data source', () async {
      when(() => mockLocalDataSource.clearIfNotLaunchedBefore())
          .thenAnswer((_) async => {});

      await repository.clearIfNotLaunchedBefore();

      verify(() => mockLocalDataSource.clearIfNotLaunchedBefore()).called(1);
    });
  });

  group('hasToken', () {
    test('returns true when token exists', () async {
      when(() => mockLocalDataSource.getToken()).thenAnswer(
        (_) async => const AuthToken(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      final result = await repository.hasToken();

      expect(result, isTrue);
    });

    test('returns false when token is null', () async {
      when(() => mockLocalDataSource.getToken()).thenAnswer((_) async => null);

      final result = await repository.hasToken();

      expect(result, isFalse);
    });
  });

  group('logout', () {
    test('emits unauthenticated status and clears storage', () async {
      when(() => mockAuthorizedDataSource.logout())
          .thenAnswer((_) async => {});
      when(() => mockLocalDataSource.clearStorage())
          .thenAnswer((_) async => {});

      final statusStream = repository.status;

      repository.logout();

      await expectLater(
        statusStream,
        emits(AuthStatus.unauthenticated),
      );
    });
  });

  group('login', () {
    test('saves token and emits authenticated status on success', () async {
      const token = AuthToken(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
      );

      when(() => mockUnauthorizedDataSource.login(any()))
          .thenAnswer((_) async => token);
      when(() => mockLocalDataSource.saveToken(any()))
          .thenAnswer((_) async => {});

      final statusStream = repository.status;

      repository.login(
        phone: '+79991234567',
        password: 'password123',
      );

      await expectLater(
        statusStream,
        emits(AuthStatus.authenticated),
      );

      verify(() => mockLocalDataSource.saveToken(token)).called(1);
    });
  });

  group('register', () {
    test('saves token and emits authenticated status on success', () async {
      const token = AuthToken(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
      );

      when(() => mockUnauthorizedDataSource.register(any()))
          .thenAnswer((_) async => token);
      when(() => mockLocalDataSource.saveToken(any()))
          .thenAnswer((_) async => {});

      final statusStream = repository.status;

      repository.register(
        name: 'Test User',
        phone: '+79991234567',
        password: 'password123',
        birthday: DateTime(1990, 1, 1),
      );

      await expectLater(
        statusStream,
        emits(AuthStatus.authenticated),
      );

      verify(() => mockLocalDataSource.saveToken(token)).called(1);
    });
  });
}
