# Exceptions — AI Context

Concise rules. Full guide: [../guides/exception_handling.md](../guides/exception_handling.md).

## Two-layer model

| Layer | Type | Purpose |
|-------|------|---------|
| Data / Domain | `AppException` (sealed Freezed) | Pure domain error, no Flutter |
| UI | `ExceptionUiModel` (Equatable) | Localized message + icon |

BLoC state holds the **`AppException`**, never the UI model. UI converts at render time via `ExceptionUiMapper(context)`.

## Adding a new exception

1. Add a sealed factory under `packages/starter_toolkit/lib/data/exceptions/app_exception.dart`:
   ```dart
   @ExceptionUiConfig(messageKey: 'rateLimitedException', icon: 'timer_off')
   const factory AppException.rateLimited() = _RateLimitedAppException;
   ```
2. Add localization key in `packages/starter_uikit/lib/l10n/intl_en.arb`.
3. Run codegen:
   ```bash
   dart run utils/generators/generate_exception_mapper.dart
   fvm flutter --no-color pub global run intl_utils:generate
   ```
4. The generator updates `ExceptionUiMapper` and `ExceptionUiMapperDecorator` automatically — do **not** edit them by hand.

## Throwing from data sources

- Wrap raw IO with `RawRepositoryExecutor().withErrorHandling()` so any thrown error is converted to `AppException`.
- For typed cases (e.g. 404 → `AppException.notFound()`), throw directly inside the data source.

## UI consumption

```dart
state.maybeMap(
  failure: (s) => FailureWidgetLarge(exception: s.exception, onRetry: _retry),
  orElse: () => const CustomCircularProgressIndicator(),
)
```

For snackbars use `NotificationSnackBar.showExceptionMessage(context, exception: ...)`.

## Repository executor decorators

```dart
final exec = RawRepositoryExecutor()
  .withErrorHandling()  // first — converts any throw to AppException
  .withRetry()          // exponential backoff
  .withCaching();       // optional time-based cache
```

Order matters: `withErrorHandling()` must be the innermost decorator.
