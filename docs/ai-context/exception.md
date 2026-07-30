# Exceptions — AI Context

Concise rules. Full guide: [../guides/exception_handling.md](../guides/exception_handling.md).

## Two-layer model

| Layer | Type | Purpose |
|-------|------|---------|
| Data / Domain | `AppException` (sealed class hierarchy) | Pure domain error, no Flutter |
| UI | `ExceptionUiModel` (Equatable) | Localized messages + retry flag |

BLoC state holds the **`AppException`**, never the UI model. UI converts at render time via `ExceptionUiMapper(context)`.

## Adding a new exception

1. Add a `final class` subtype under `packages/starter_toolkit/lib/data/exceptions/app_exception.dart`,
   annotated with `@ExceptionUiConfig` (params: `descriptionKey` required, `titleKey` / `snackbarKey` optional):
   ```dart
   @ExceptionUiConfig(
     titleKey: 'errorMessageRateLimited',
     descriptionKey: 'errorMessageRateLimitedDescription',
   )
   final class RateLimitedException extends AppException {
     const RateLimitedException();

     @override
     String get name => 'RateLimited';

     @override
     bool get canRetry => true;
   }
   ```
2. Add the localization key(s) in `packages/starter_uikit/lib/l10n/intl_en.arb`.
3. Run codegen:
   ```bash
   dart run utils/generators/generate_exception_mapper.dart
   fvm flutter --no-color pub global run intl_utils:generate
   ```
4. The generator updates `ExceptionUiMapper` and `ExceptionUiMapperDecorator` automatically — do **not** edit them by hand.

## Throwing from data sources

- Wrap raw IO with `RawRepositoryExecutor().withErrorHandling()` so any thrown error is converted to `AppException`.
- For typed cases (e.g. 404 → `ServerException(statusCode: 404)`), throw directly inside the data source; `AppException.fromDioResponse` maps common status codes.

## UI consumption

```dart
switch (state) {
  FailureMyState(:final exception) => FailureWidget.large(
    exception: exception,
    onRetry: _retry,
  ),
  _ => const CustomCircularProgressIndicator.adaptive(),
}
```

For snackbars use `NotificationSnackBar.showExceptionMessage(context, exception: ...)`.

## Repository executor decorators

`withErrorHandling()` converts any throw to an `AppException` and must be the
innermost decorator. Everything else about executor composition, caching, and
testing → [repository_executor.md](repository_executor.md).
