import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Answers one request; may throw to simulate a transport failure.
typedef FakeResponder = Future<ResponseBody> Function(RequestOptions options);

/// [HttpClientAdapter] that never touches the network: every request is
/// recorded in [requests] and answered by [respond].
class FakeHttpClientAdapter implements HttpClientAdapter {
  FakeHttpClientAdapter(this.respond);

  final FakeResponder respond;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);

    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

/// JSON response body with the matching content type.
ResponseBody jsonBody(Object? data, {int statusCode = 200}) =>
    ResponseBody.fromString(
      jsonEncode(data),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

/// Dio wired to [adapter] with the given [interceptors], as the app builds it.
Dio fakeDio(
  FakeHttpClientAdapter adapter, {
  List<Interceptor> interceptors = const [],
}) {
  final dio = Dio()..httpClientAdapter = adapter;
  dio.interceptors.addAll(interceptors);

  return dio;
}
