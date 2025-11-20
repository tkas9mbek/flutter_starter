import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

/// Dio-based implementation of [ApiClient].
///
/// Handles HTTP requests using Dio with methods organized by response type.
class DioApiClient implements ApiClient {
  DioApiClient({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  @override
  String get baseUrl => _baseUrl;

  @override
  Future<T> requestJson<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.json,
    );

    final json = response.data as Map<String, dynamic>;

    return fromJson(json);
  }

  @override
  Future<List<T>> requestJsonList<T>({
    required HttpMethod method,
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.json,
    );

    final jsonList = response.data as List<dynamic>;

    return jsonList
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> requestVoid({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.json,
    );
  }

  @override
  Future<String> requestPlainText({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.plain,
    );

    return response.data as String;
  }

  @override
  Future<List<int>> requestBytes({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.bytes,
    );

    return response.data as List<int>;
  }

  @override
  Future<Stream<List<int>>> requestStream({
    required HttpMethod method,
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _request(
      method: method,
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      responseType: ResponseType.stream,
    );

    return response.data as Stream<List<int>>;
  }

  Future<Response<dynamic>> _request({
    required HttpMethod method,
    required String path,
    required ResponseType responseType,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    final url = _buildUrl(path);
    final options = Options(
      headers: headers,
      responseType: responseType,
    );

    switch (method) {
      case HttpMethod.get:
        return _dio.get<dynamic>(
          url,
          queryParameters: queryParameters,
          options: options,
        );

      case HttpMethod.post:
        return _dio.post<dynamic>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );

      case HttpMethod.put:
        return _dio.put<dynamic>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );

      case HttpMethod.patch:
        return _dio.patch<dynamic>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );

      case HttpMethod.delete:
        return _dio.delete<dynamic>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
    }
  }

  String _buildUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    return '$_baseUrl$path';
  }
}
