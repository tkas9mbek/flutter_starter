import 'package:request_logger/data/http_response_bean.dart';

/// Captured failure of an [HttpBean] — a Dio error with no successful
/// response, or a response whose status code marked it as failed.
final class HttpErrorBean {
  HttpErrorBean({
    required this.id,
    required this.url,
    required this.errorTime,
    this.response,
    this.duration,
    this.headers,
    this.errorMessage,
    this.statusMessage,
    this.statusCode,
    this.errorData,
  });

  final int id;
  final Uri url;
  final DateTime? errorTime;
  final HttpResponseBean? response;
  final String? errorMessage;
  final String? statusMessage;
  final int? statusCode;
  final dynamic errorData;
  int? duration;
  Map<String, dynamic>? headers;
}
