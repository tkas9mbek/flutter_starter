import 'package:flutter_test/flutter_test.dart';
import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_log_manager.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';

void main() {
  final manager = HttpLogManager.instance;
  final url = Uri.parse('https://api.test/tasks');
  final requestTime = DateTime(2026, 1, 1, 12);

  HttpRequestBean request(int id) => HttpRequestBean(
    id: id,
    url: url,
    requestTime: requestTime,
    method: 'GET',
  );

  setUp(manager.cleanHTTP);

  tearDown(() => manager.updateHttpPage = null);

  test('lists calls in capture order and ignores a repeated id', () {
    manager
      ..onRequest(request(1))
      ..onRequest(request(2))
      ..onRequest(request(1));

    expect(manager.logValues().map((log) => log.request?.id), [1, 2]);
  });

  test('evicts the oldest call once 50 are stored', () {
    for (var id = 0; id < 51; id++) {
      manager.onRequest(request(id));
    }

    final ids = manager.logValues().map((log) => log.request?.id).toList();
    expect(ids, hasLength(50));
    expect(ids.first, 1);
    expect(ids.last, 50);
  });

  test('pairs a response with its request and measures duration', () {
    manager
      ..onRequest(request(1))
      ..onResponse(
        HttpResponseBean(
          id: 1,
          url: url,
          responseTime: requestTime.add(const Duration(milliseconds: 250)),
          statusCode: 200,
        ),
      );

    final log = manager.logValues().single;
    expect(log.response?.statusCode, 200);
    expect(log.response?.duration, 250);
    expect(log.error, isNull);
  });

  test('pairs an error with its request and measures duration', () {
    manager
      ..onRequest(request(1))
      ..onError(
        HttpErrorBean(
          id: 1,
          url: url,
          errorTime: requestTime.add(const Duration(milliseconds: 400)),
          errorType: 'badResponse',
          statusCode: 500,
        ),
      );

    final log = manager.logValues().single;
    expect(log.error?.errorType, 'badResponse');
    expect(log.error?.duration, 400);
    expect(log.response, isNull);
  });

  test('drops a response or error whose request is not stored', () {
    manager
      ..onResponse(HttpResponseBean(id: 7, url: url, responseTime: requestTime))
      ..onError(HttpErrorBean(id: 7, url: url, errorTime: requestTime));

    expect(manager.logValues(), isEmpty);
  });

  test('notifies the listening page on every change', () {
    var notifications = 0;
    manager.updateHttpPage = () => notifications++;

    manager
      ..onRequest(request(1))
      ..onResponse(HttpResponseBean(id: 1, url: url, responseTime: requestTime))
      ..onRequest(request(2))
      ..onError(HttpErrorBean(id: 2, url: url, errorTime: requestTime))
      ..cleanHTTP();

    expect(notifications, 5);
    expect(manager.logValues(), isEmpty);
  });
}
