# Request Logger

In-app HTTP request/response logger for debug and staging builds: a Dio interceptor captures every call, and a small pill button opens a list of the captured requests with their details. Sensitive headers and body fields are redacted before anything is stored.

## Features

- **Dio interceptor** that records each request, response and error (timing, headers, query params, body)
- **Redaction** of configured header and body-field names to `Hidden` before they reach memory
- **Log list screen** (newest first, live-updating, clear action) with a status pill per call
- **Log details screen** with a summary header and `Request` / `Response` (or `Error`) tabs, each copyable to the clipboard
- **`RequestLoggerButton`**: compact pill that opens the list from anywhere, even outside the routed content
- In-memory store capped at the 50 newest calls — nothing is persisted

## Installation

The package is a workspace member and a path dependency of the app:

```yaml
dependencies:
  request_logger:
    path: ./packages/request_logger
```

It depends on `dio`, `intl` and `starter_uikit` (all screens use its theme tokens and widgets, so the host app must provide a `ThemeProvider` and `UikitLocalizer`).

## Usage

There is no barrel export — import specific files.

### Wire the interceptor into Dio

`RequestLogger.dioInterceptor()` returns the interceptor preconfigured to hide the `authorization` / `Authorization` headers and the `refreshToken`, `accessToken` and `authToken` body fields. The app adds it only for environments that show the banner (`dev`, `mock`), and **after** the other interceptors so it sees the final error:

```dart
import 'package:request_logger/controller/request_logger.dart';

final requestLoggerInterceptors = env.showBanner
    ? [RequestLogger.dioInterceptor()]
    : const <Interceptor>[];

final dio = dioProvider.getDio(
  useToken: true,
  extraInterceptors: requestLoggerInterceptors,   // appended last
);
```

Being last means that behind `AppErrorInterceptor` the logger records the mapped `AppException` as the error plus the original Dio error type and message (and the server response body when there was one).

To redact other names, construct the interceptor directly:

```dart
import 'package:request_logger/interceptor/dio_log_interceptor.dart';

dio.interceptors.add(
  DioLogInterceptor(
    hiddenHeaders: const ['x-api-key'],
    hiddenFields: const ['password'],
  ),
);
```

Header names are matched exactly (case-sensitive, which is why both `authorization` spellings are listed). Field names are matched at any depth of a `Map` body, in query parameters and inside lists of maps; a body that is not a `Map` (a string, a `FormData`) is stored as is.

### Open the log from the UI

`RequestLoggerButton` renders outside the routed content (the app stacks it above the router in an environment banner), so it has no `Navigator` ancestor and pushes through the app's `navigatorKey`:

```dart
import 'package:request_logger/widget/request_logger_button.dart';

RequestLoggerButton(
  label: env.name,
  color: env.useMock ? theme.info : theme.warning,   // optional; defaults to theme.warning
  navigatorKey: navigatorKey,
)
```

The app shows it only when `env.showBanner` is true; see `EnvironmentBannerStack` in `lib/features/application/environment/ui/switcher/widget/`.

### Screens

- `RequestLogListScreen` (`screen/request_log_list_screen.dart`): rows with method badge, path, host and duration, and a `StatusPill` on the right. The pill is colored by HTTP class (2xx `success`, 4xx `warning`, 5xx and calls with no response `error`, other `info`) and shows the status code, or the error type when there was none. A spinner replaces it while the call is in flight. The trash action clears the log.
- `RequestLogDetailsScreen` (`screen/request_log_details_screen.dart`): summary header, then `Request` (headers, params, body) and `Response` or `Error` (message, type, status code, data) tabs. The copy action copies the active tab as pretty-printed JSON.

## Public API

| Class | File | Role |
|---|---|---|
| `RequestLogger` | `controller/request_logger.dart` | `dioInterceptor()` — the preconfigured interceptor |
| `DioLogInterceptor` | `interceptor/dio_log_interceptor.dart` | Dio `Interceptor` taking `hiddenHeaders` / `hiddenFields` |
| `LogRedactor` | `interceptor/log_redactor.dart` | Replaces hidden names with `Hidden` |
| `HttpLogManager` | `data/http_log_manager.dart` | Singleton in-memory store (`instance`, `logValues()`, `cleanHTTP()`) |
| `HttpBean`, `HttpRequestBean`, `HttpResponseBean`, `HttpErrorBean` | `data/` | Captured call records |
| `RequestStatus` | `data/request_status.dart` | `sending`, `success`, `error`, `noInternet` (from `HttpBean.status`) |
| `RequestLogListScreen`, `RequestLogDetailsScreen` | `screen/` | The two screens |
| `RequestLoggerButton` | `widget/request_logger_button.dart` | Pill that opens the list |

## Development

### Tests

```bash
cd packages/request_logger
fvm flutter test
```

`test/dio_log_interceptor_test.dart` covers capture, timing, redaction, the 50-call cap and the real interceptor chain (with `AppErrorInterceptor`); `test/request_log_ui_test.dart` covers the list/details screens, status pill colors and the button. Requests run against `test/support/fake_adapter.dart`, so no network is needed.

## Related Packages

- **starter_uikit**: Theme tokens, `TitleAppBar`, `StatusPill`, `EmptyInformationBody` and the localization delegate used by the screens
- **starter_toolkit**: Dev dependency only — tests use `AppErrorInterceptor`

## License

Private package for internal use.
