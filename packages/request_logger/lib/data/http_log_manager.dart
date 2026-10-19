import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';

const _maxLogsCount = 50;

/// In-memory store of captured HTTP calls, keyed by request id, newest
/// request evicting the oldest once [_maxLogsCount] is exceeded.
final class HttpLogManager {
  HttpLogManager._();

  static final HttpLogManager instance = HttpLogManager._();

  final _logs = <String, HttpBean>{};
  final _keys = <String>[];

  /// Set by the log list screen to refresh itself on every capture event.
  void Function()? updateHttpPage;

  void onRequest(HttpRequestBean request) {
    final key = request.id.toString();
    if (_keys.contains(key)) {
      return;
    }

    if (_logs.length >= _maxLogsCount) {
      _logs.remove(_keys.removeLast());
    }
    _keys.insert(0, key);
    _logs[key] = HttpBean(request: request);
    updateHttpPage?.call();
  }

  void onResponse(HttpResponseBean response) {
    final key = response.id.toString();
    final log = _logs[key];
    if (log == null) {
      return;
    }

    final requestTime = log.request?.requestTime.millisecondsSinceEpoch;
    if (requestTime != null) {
      response.duration =
          response.responseTime.millisecondsSinceEpoch - requestTime;
    }
    log.response = response;
    updateHttpPage?.call();
  }

  void onError(HttpErrorBean error) {
    final key = error.id.toString();
    final log = _logs[key];
    if (log == null) {
      return;
    }

    final errorTime = error.errorTime?.millisecondsSinceEpoch;
    final requestTime = log.request?.requestTime.millisecondsSinceEpoch;
    if (errorTime != null && requestTime != null) {
      error.duration = errorTime - requestTime;
    }
    log.error = error;
    updateHttpPage?.call();
  }

  List<HttpBean> logValues() => _logs.values.toList();

  void cleanHTTP() {
    _logs.clear();
    _keys.clear();
    updateHttpPage?.call();
  }
}
