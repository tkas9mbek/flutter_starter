# Changelog

All notable changes to request_logger will be documented in this file.

## [0.1.0] - 2026-10-08

First release, shipped with app `3.1.0`.

### Added
- `DioLogInterceptor` and `RequestLogger.dioInterceptor()` — capture every request, response and error into an in-memory `HttpLogManager` (50 newest calls)
- `LogRedactor` — hides configured header and body-field names (`authorization`, `refreshToken`, `accessToken`, `authToken` by default) before capture
- `RequestLogListScreen` with a `StatusPill` per call colored by HTTP status class (2xx success, 4xx warning, 5xx or no response error), and `RequestLogDetailsScreen` with `Request` and `Response` / `Error` tabs and copy-to-clipboard
- `RequestLoggerButton` — flat pill that opens the list through the app's `navigatorKey`; optional `color` (defaults to `theme.warning`)
- Error logs show the error type, message and server response body, and keep the original Dio cause when behind `AppErrorInterceptor`
- Interceptor, redaction and UI tests under `test/`

### Changed
- Screens and the button are styled with the flat `starter_uikit` tokens (`AppRadii`, `StatusPill`, `theme.accent`, `onStatus`)
