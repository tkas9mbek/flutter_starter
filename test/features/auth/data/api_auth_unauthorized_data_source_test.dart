import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/data/api_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

import '../model/auth_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

AuthToken _fakeFromJson(Map<String, dynamic> json) => AuthToken.fromJson(json);

void main() {
  late ApiAuthUnauthorizedDataSource dataSource;
  late MockApiClient mockApiClient;

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
    registerFallbackValue(_fakeFromJson);
  });

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiAuthUnauthorizedDataSource(mockApiClient);
  });

  group(
    'login',
    () => test(
      'calls ApiClient with correct parameters and returns AuthToken',
      () async {
        const body = AuthLoginRequestBody(
          phone: '+79991234567',
          password: 'password123',
        );

        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((invocation) async {
          final fromJson =
              invocation.namedArguments[#fromJson]
                  as AuthToken Function(Map<String, dynamic>);

          return fromJson(AuthMockModels.rawToken);
        });

        final result = await dataSource.login(body);

        expect(
          result.accessToken,
          equals(AuthMockModels.authToken.accessToken),
        );
        expect(
          result.refreshToken,
          equals(AuthMockModels.authToken.refreshToken),
        );
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: HttpMethod.post,
            path: '/auth/login',
            body: body.toJson(),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    ),
  );

  group(
    'register',
    () => test(
      'calls ApiClient with correct parameters and returns AuthToken',
      () async {
        final body = AuthRegisterRequestBody(
          name: 'Test User',
          phone: '+79991234567',
          password: 'password123',
          birthday: DateTime(1990, 1, 1),
        );

        when(
          () => mockApiClient.requestJson<AuthToken>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((invocation) async {
          final fromJson =
              invocation.namedArguments[#fromJson]
                  as AuthToken Function(Map<String, dynamic>);

          return fromJson(AuthMockModels.rawToken);
        });

        final result = await dataSource.register(body);

        expect(
          result.accessToken,
          equals(AuthMockModels.authToken.accessToken),
        );
        expect(
          result.refreshToken,
          equals(AuthMockModels.authToken.refreshToken),
        );
        verify(
          () => mockApiClient.requestJson<AuthToken>(
            method: HttpMethod.post,
            path: '/auth/register',
            body: body.toJson(),
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    ),
  );

  group(
    'requestOtp',
    () => test('posts the phone to /auth/request-otp', () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/request-otp',
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.requestOtp(
        const AuthOtpRequestBody(phone: '+79991234567'),
      );

      final body = verify(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/request-otp',
          body: captureAny(named: 'body'),
        ),
      ).captured.single;
      expect(body, {'phone': '+79991234567'});
    }),
  );

  group('verifyOtp', () {
    test('posts phone and code and decodes the AuthToken', () async {
      when(
        () => mockApiClient.requestJson<AuthToken>(
          method: HttpMethod.post,
          path: '/auth/verify-otp',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson]
                as AuthToken Function(Map<String, dynamic>);

        return fromJson(AuthMockModels.rawToken);
      });

      final result = await dataSource.verifyOtp(
        const AuthVerifyOtpRequestBody(phone: '+79991234567', otp: '1234'),
      );

      expect(result, AuthMockModels.authToken);
      final body = verify(
        () => mockApiClient.requestJson<AuthToken>(
          method: HttpMethod.post,
          path: '/auth/verify-otp',
          body: captureAny(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).captured.single;
      expect(body, {'phone': '+79991234567', 'otp': '1234'});
    });

    test('propagates a client failure', () {
      when(
        () => mockApiClient.requestJson<AuthToken>(
          method: HttpMethod.post,
          path: '/auth/verify-otp',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.verifyOtp(
          const AuthVerifyOtpRequestBody(phone: '+79991234567', otp: '0000'),
        ),
        throwsA(isA<Exception>()),
      );
    });
  });

  group(
    'AuthLoginRequestBody',
    () => test('toJson serializes correctly', () {
      const body = AuthLoginRequestBody(
        phone: '+79991234567',
        password: 'password123',
      );

      final json = body.toJson();

      expect(json['phone'], equals('+79991234567'));
      expect(json['password'], equals('password123'));
      expect(json.length, equals(2));
    }),
  );

  group(
    'AuthRegisterRequestBody',
    () => test('toJson serializes correctly', () {
      final birthday = DateTime(1990, 1, 15);
      final body = AuthRegisterRequestBody(
        name: 'Test User',
        phone: '+79991234567',
        password: 'password123',
        birthday: birthday,
      );

      final json = body.toJson();

      expect(json['name'], equals('Test User'));
      expect(json['phone'], equals('+79991234567'));
      expect(json['password'], equals('password123'));
      expect(json['birthday'], equals(birthday.toIso8601String()));
      expect(json.length, equals(4));
    }),
  );
}
