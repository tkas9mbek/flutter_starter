/// Captured request half of an [HttpBean].
final class HttpRequestBean {
  HttpRequestBean({
    required this.id,
    required this.url,
    required this.requestTime,
    required this.method,
    this.duration,
    this.headers,
    this.connectTimeout,
    this.receiveTimeout,
    this.contentType,
    this.params,
    this.body,
  });

  final int id;
  final Uri url;
  final DateTime requestTime;
  final String method;
  final int? connectTimeout;
  final int? receiveTimeout;
  final String? contentType;
  final Map<String, dynamic>? params;
  int? duration;
  Map<String, dynamic>? headers;
  dynamic body;
}
