/// Captured response half of an [HttpBean].
final class HttpResponseBean {
  HttpResponseBean({
    required this.id,
    required this.url,
    required this.responseTime,
    this.statusCode,
    this.statusMessage,
    this.duration,
    this.headers,
    this.data,
    this.method,
  });

  final int id;
  final Uri url;
  final DateTime responseTime;
  final int? statusCode;
  final String? statusMessage;
  final String? method;
  final dynamic data;
  int? duration;
  Map<String, dynamic>? headers;
}
