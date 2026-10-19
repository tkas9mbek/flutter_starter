import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/interceptor/app_error_interceptor.dart';
import 'package:starter_toolkit/data/interceptor/auth_refresh_interceptor.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

import '../../support/fake_http_client_adapter.dart';

const _url = 'https://api.test/profile';

/// Client-side session wired like `DioProvider`: a token-attaching
/// interceptor on both Dios, refresh only on the main one.
class _Session {
  _Session(FakeResponder respond)
    : adapter = FakeHttpClientAdapter(respond),
      sentTokens = [];

  final FakeHttpClientAdapter adapter;

  /// Token on each request as it left the client; the replay reuses (and
  /// mutates) the original `RequestOptions`, so they cannot be read later.
  final List<Object?> sentTokens;
  String token = 'stale';
  int refreshCalls = 0;
  int logoutCalls = 0;

  late final _attachToken = InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = token;
      sentTokens.add(token);
      handler.next(options);
    },
  );

  Future<void> refresh() async {
    refreshCalls++;
    token = 'fresh';
  }

  Future<void> logout() async => logoutCalls++;

  Dio buildDio({
    Future<void> Function()? tryRefreshToken,
    bool withRefresh = true,
    List<Interceptor> extra = const [],
  }) => fakeDio(
    adapter,
    interceptors: [
      _attachToken,
      AuthRefreshInterceptor(
        dio: fakeDio(adapter, interceptors: [_attachToken]),
        tryRefreshToken: withRefresh ? tryRefreshToken ?? refresh : null,
        logout: logout,
      ),
      ...extra,
    ],
  );
}

/// Accepts only the `fresh` token; anything else is a 401.
Future<ResponseBody> _acceptFreshToken(RequestOptions options) async =>
    options.headers['Authorization'] == 'fresh'
    ? jsonBody({'name': 'Ann'})
    : jsonBody({'message': 'Expired'}, statusCode: 401);

void main() {
  test(
    'refreshes on a 401 and replays the request with the new token',
    () async {
      final session = _Session(_acceptFreshToken);

      final response = await session.buildDio().get<Map<String, dynamic>>(_url);

      expect(response.data, {'name': 'Ann'});
      expect(session.refreshCalls, 1);
      expect(session.logoutCalls, 0);
      expect(session.sentTokens, ['stale', 'fresh']);
    },
  );

  test('passes non-401 errors on without refreshing', () async {
    final session = _Session((_) async => jsonBody(const {}, statusCode: 500));

    await expectLater(
      session.buildDio().get<Object?>(_url),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          500,
        ),
      ),
    );
    expect(session.refreshCalls, 0);
    expect(session.logoutCalls, 0);
  });

  test('logs out when the replayed request is still a 401', () async {
    final session = _Session(
      (_) async => jsonBody({'message': 'Revoked'}, statusCode: 401),
    );

    await expectLater(
      session.buildDio().get<Object?>(_url),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          401,
        ),
      ),
    );
    expect(session.refreshCalls, 1);
    expect(session.logoutCalls, 1);
    expect(session.adapter.requests, hasLength(2));
  });

  test('keeps the session when the replay fails for another reason', () async {
    final session = _Session(
      (options) async => options.headers['Authorization'] == 'fresh'
          ? jsonBody(const {}, statusCode: 500)
          : jsonBody(const {}, statusCode: 401),
    );

    await expectLater(
      session.buildDio().get<Object?>(_url),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          500,
        ),
      ),
    );
    expect(session.logoutCalls, 0);
  });

  test(
    'logs out and surfaces the cause when the refresh call throws',
    () async {
      final session = _Session(_acceptFreshToken);
      final refreshError = Exception('refresh token expired');

      await expectLater(
        session
            .buildDio(tryRefreshToken: () async => throw refreshError)
            .get<Object?>(_url),
        throwsA(
          isA<DioException>()
              .having((e) => e.type, 'type', DioExceptionType.unknown)
              .having((e) => e.error, 'error', same(refreshError)),
        ),
      );
      expect(session.logoutCalls, 1);
      expect(session.adapter.requests, hasLength(1));
    },
  );

  test('logs out on a 401 when no refresh callback is wired', () async {
    final session = _Session(_acceptFreshToken);

    await expectLater(
      session.buildDio(withRefresh: false).get<Object?>(_url),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          401,
        ),
      ),
    );
    expect(session.logoutCalls, 1);
    expect(session.adapter.requests, hasLength(1));
  });

  test('a rejected 401 still reaches the repository as Unauthorized', () async {
    // A rejection skips AppErrorInterceptor, so the executor maps the status.
    final session = _Session(_acceptFreshToken);
    final dio = session.buildDio(
      withRefresh: false,
      extra: const [AppErrorInterceptor()],
    );

    await expectLater(
      const RawRepositoryExecutor().withErrorHandling().execute(
        () => dio.get<Object?>(_url),
      ),
      throwsA(
        isA<UnauthorizedException>().having(
          (e) => e.message,
          'message',
          'Expired',
        ),
      ),
    );
  });

  test('handles concurrent 401s one at a time and replays both', () async {
    final session = _Session(_acceptFreshToken);
    var activeRefreshes = 0;
    var maxActiveRefreshes = 0;

    Future<void> slowRefresh() async {
      activeRefreshes++;
      if (activeRefreshes > maxActiveRefreshes) {
        maxActiveRefreshes = activeRefreshes;
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await session.refresh();
      activeRefreshes--;
    }

    final dio = session.buildDio(tryRefreshToken: slowRefresh);
    final responses = await Future.wait([
      dio.get<Map<String, dynamic>>(_url),
      dio.get<Map<String, dynamic>>(_url),
    ]);

    expect(responses.map((r) => r.data), [
      {'name': 'Ann'},
      {'name': 'Ann'},
    ]);
    expect(maxActiveRefreshes, 1);
    expect(session.logoutCalls, 0);
  });
}
