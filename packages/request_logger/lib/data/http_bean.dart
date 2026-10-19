import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';
import 'package:request_logger/data/request_status.dart';

/// One HTTP call captured by [DioLogInterceptor]: its request plus whichever
/// of [response] or [error] has arrived so far.
final class HttpBean {
  HttpBean({this.request, this.response, this.error});

  HttpRequestBean? request;
  HttpResponseBean? response;
  HttpErrorBean? error;
}

extension HttpBeanExtension on HttpBean {
  RequestStatus get status {
    final error = this.error;
    if (error != null) {
      return isInternetError ? RequestStatus.noInternet : RequestStatus.error;
    }

    final response = this.response;
    if (response != null) {
      return response.statusCode == null
          ? RequestStatus.error
          : RequestStatus.success;
    }

    return RequestStatus.sending;
  }

  bool get isInternetError {
    final error = this.error;
    if (error == null || error.statusCode != null) {
      return false;
    }

    final errorMessage = error.errorMessage;
    if (errorMessage != null && errorMessage.contains('Connecting timed out')) {
      return true;
    }

    final errorData = error.errorData;
    if (errorData is Map<String, dynamic>) {
      final errorCode = errorData['OS Error code'];

      return errorCode == 7 ||
          errorCode == 8 ||
          errorCode == 101 ||
          errorCode == 103 ||
          errorData['No internet'] == true;
    }

    // AppErrorInterceptor replaces the socket error, so fall back to the Dio type.
    return error.errorType == 'connectionTimeout' ||
        error.errorType == 'connectionError';
  }
}
