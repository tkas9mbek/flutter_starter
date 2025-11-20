import 'package:starter_toolkit/data/client/http_method.dart';

/// Abstract API client interface for making HTTP requests.
///
/// Provides a clean abstraction over HTTP operations organized by
/// response type rather than HTTP method.
///
/// Implementations should handle:
/// - Request serialization (JSON encoding, multipart forms, etc.)
/// - Response deserialization (JSON parsing, byte conversion, etc.)
/// - Error handling and exception mapping
/// - Authentication and token management
abstract class ApiClient {
  /// Base URL for all requests made by this client.
  String get baseUrl;

  /// Performs a request that returns a JSON-deserialized object of type [T].
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [fromJson] - Function to deserialize JSON to [T]
  /// [body] - Optional request body (for POST, PUT, PATCH)
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns deserialized response of type [T].
  ///
  /// Example:
  /// ```dart
  /// final user = await client.requestJson<User>(
  ///   HttpMethod.get,
  ///   '/profile',
  ///   fromJson: User.fromJson,
  /// );
  ///
  /// final token = await client.requestJson<AuthToken>(
  ///   HttpMethod.post,
  ///   '/auth/login',
  ///   body: {'phone': '+1234567890', 'password': 'secret'},
  ///   fromJson: AuthToken.fromJson,
  /// );
  /// ```
  Future<T> requestJson<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns a JSON-deserialized list of type [T].
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [fromJson] - Function to deserialize each JSON item to [T]
  /// [body] - Optional request body (for POST, PUT, PATCH)
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns deserialized list of [T].
  ///
  /// Example:
  /// ```dart
  /// final tasks = await client.requestJsonList<Task>(
  ///   HttpMethod.get,
  ///   '/tasks',
  ///   fromJson: Task.fromJson,
  /// );
  /// ```
  Future<List<T>> requestJsonList<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns void (no response body expected).
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [body] - Optional request body (for POST, PUT, PATCH)
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Example:
  /// ```dart
  /// await client.requestVoid(
  ///   HttpMethod.post,
  ///   '/auth/logout',
  /// );
  ///
  /// await client.requestVoid(
  ///   HttpMethod.delete,
  ///   '/tasks/123',
  /// );
  /// ```
  Future<void> requestVoid({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns plain text.
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [body] - Optional request body
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns response body as String.
  ///
  /// Example:
  /// ```dart
  /// final html = await client.requestPlainText(
  ///   HttpMethod.get,
  ///   '/healthcheck',
  /// );
  /// ```
  Future<String> requestPlainText({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns binary data.
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [body] - Optional request body
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns response body as List<int> (bytes).
  ///
  /// Example:
  /// ```dart
  /// final bytes = await client.requestBytes(
  ///   HttpMethod.get,
  ///   '/files/document.pdf',
  /// );
  /// ```
  Future<List<int>> requestBytes({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a request that returns a stream of binary data.
  ///
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [path] - The endpoint path (will be appended to baseUrl)
  /// [body] - Optional request body
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns response body as Stream<List<int>>.
  ///
  /// Example:
  /// ```dart
  /// final stream = await client.requestStream(
  ///   HttpMethod.get,
  ///   '/videos/large-video.mp4',
  /// );
  /// ```
  Future<Stream<List<int>>> requestStream({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
