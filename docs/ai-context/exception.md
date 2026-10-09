# Exceptions — AI Context

Concise rules. Full guide: [../guides/exception_handling.md](../guides/exception_handling.md).

## Two-layer model

| Layer | Type | Purpose |
|-------|------|---------|
| Data / Domain | `AppException` (sealed class hierarchy) | Pure domain error, no Flutter |
| UI | `ExceptionUiModel` (Equatable) | Localized messages + retry flag |

BLoC state holds the **`AppException`**, never the UI model; UI converts at render time via `ExceptionUiMapper(context)`.

## Adding a new exception

1. Add a `final class` subtype in `packages/starter_toolkit/lib/data/exceptions/app_exception.dart` with `@ExceptionUiConfig` (`descriptionKey` required; `titleKey` / `snackbarKey` optional):
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
2. Add the key(s) to `packages/starter_uikit/lib/l10n/intl_en.arb`.
3. Run `dart run utils/generators/generate_exception_mapper.dart` and `fvm flutter --no-color pub global run intl_utils:generate`.
4. The generator updates `ExceptionUiMapper` and `ExceptionUiMapperDecorator` — never edit them by hand.

## Throwing from data sources

- `RawRepositoryExecutor().withErrorHandling()` converts any thrown error to `AppException` (must be the innermost decorator; rest in [repository_executor.md](repository_executor.md)).
- Typed cases (404 → `ServerException(statusCode: 404)`): throw directly in the data source; `AppException.fromDioResponse` maps common status codes. Mock twins throw backend-shaped `AppException`s the same way ([mocking.md](mocking.md) `M6`).

## UI consumption

```dart
switch (state) {
  FailureMyState(:final exception) => FailureWidget.large(exception: exception, onRetry: _retry),
  _ => const CustomCircularProgressIndicator.adaptive(),
}
```

Snackbars: `NotificationSnackBar.showExceptionMessage(context, exception: ...)`. Handler side: catch `AppException` ([bloc.md](bloc.md)).
