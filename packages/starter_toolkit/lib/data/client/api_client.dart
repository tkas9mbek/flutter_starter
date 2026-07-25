import 'package:starter_toolkit/data/client/http_method.dart';

/// Abstract HTTP client interface, organized by response type rather than HTTP method.
abstract class ApiClient {
  /// Base URL for all requests made by this client.
  String get baseUrl;

  /// Performs a request that returns a JSON-deserialized object of type [T].
  Future<T> requestJson<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns a JSON-deserialized list of type [T].
  Future<List<T>> requestJsonList<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns void (no response body expected).
  Future<void> requestVoid({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns the response body as plain text.
  Future<String> requestPlainText({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns the response body as raw bytes.
  Future<List<int>> requestBytes({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns the response body as a stream of bytes.
  Future<Stream<List<int>>> requestStream({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
