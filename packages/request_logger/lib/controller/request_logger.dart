import 'package:dio/dio.dart';
import 'package:request_logger/interceptor/dio_log_interceptor.dart';

/// Entry point the host app's DI layer touches to enable HTTP log capture.
class RequestLogger {
  const RequestLogger._();

  static Interceptor dioInterceptor() => DioLogInterceptor(
    hiddenHeaders: const ['authorization', 'Authorization'],
    hiddenFields: const ['refreshToken', 'accessToken', 'authToken'],
  );
}
