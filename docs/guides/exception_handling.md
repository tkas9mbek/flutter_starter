# Exception Handling

Cross-cutting call behavior (retry, caching, custom decorators) is covered in
[repository_executor.md](repository_executor.md).

## Architecture

Two-layer exception system:
- **Data Layer** (`starter_toolkit`): Pure Dart `AppException` sealed class hierarchy with `@ExceptionUiConfig` annotations
- **UI Layer** (`starter_uikit`): `ExceptionUiModel` with localized messages

**Benefits**: No BuildContext in data layer, type-safe exhaustive pattern matching, decorator extensibility, code generation.

### Data Layer: AppException

```dart
sealed class AppException implements Exception {
  const AppException();
  String get name;
  bool get canRetry;
}

@ExceptionUiConfig(
  titleKey: 'errorMessageNoConnection',
  descriptionKey: 'errorMessageCouldNotConnectServer',
  snackbarKey: 'errorMessageNoConnection',
)
final class NoInternetException extends AppException {
  const NoInternetException();

  @override
  String get name => 'NoInternet';

  @override
  bool get canRetry => true;
}

@ExceptionUiConfig(
  titleKey: 'errorMessageErrorWhileRequesting',
  descriptionKey: 'errorMessageDefaultRequestError',
)
final class ServerException extends AppException {
  const ServerException({required this.statusCode, this.message});

  final int? statusCode;
  final String? message;

  @override
  String get name => 'Server';

  @override
  bool get canRetry => true;
}
```

`@ExceptionUiConfig` accepts exactly three parameters: `descriptionKey` (required), `titleKey`
(optional), and `snackbarKey` (optional; falls back to `descriptionKey`). Whether the UI shows a
retry action comes from the exception's own `canRetry` getter, not from the annotation.

### UI Layer: ExceptionUiModel

Actual model in `packages/starter_uikit/lib/models/exception_ui_model.dart`:

```dart
class ExceptionUiModel extends Equatable {
  const ExceptionUiModel({
    required this.description,
    required this.snackbarDescription,
    this.canRetry = true,
    this.title,
  });

  /// For "no retry" scenarios.
  const ExceptionUiModel.noRetry({
    required String description,
    String? title,
    String? snackbarDescription,
  }) : ...;

  /// All defaults: snackbar text mirrors the description, canRetry stays true.
  const ExceptionUiModel.simple({
    required String description,
    bool canRetry = true,
  }) : ...;

  final String? title;
  final String description;
  final String snackbarDescription;
  final bool canRetry;
}
```

### Mapper: ExceptionUiMapper

Auto-generated using switch expressions for exhaustive pattern matching
(`packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart`):

```dart
class ExceptionUiMapper {
  ExceptionUiMapper(BuildContext context)
    : _localizer = UikitLocalizer.of(context);

  final UikitLocalizer _localizer;

  ExceptionUiModel map(AppException exception) {
    return switch (exception) {
      NoInternetException() => mapNoInternet(),
      ServerException(statusCode: final statusCode, message: final message) =>
        mapServer(statusCode, message),
      UnauthorizedException(message: final message) => mapUnauthorized(message),
      // ... one case per AppException subtype
    };
  }

  @protected
  ExceptionUiModel mapNoInternet() {
    return ExceptionUiModel(
      description: _localizer.errorMessageCouldNotConnectServer,
      snackbarDescription: _localizer.errorMessageNoConnection,
      title: _localizer.errorMessageNoConnection,
      canRetry: true,
    );
  }

  @protected
  ExceptionUiModel mapServer(int? statusCode, String? message) {
    return ExceptionUiModel(
      description: message ?? _localizer.errorMessageDefaultRequestError,
      snackbarDescription: message ?? _localizer.errorMessageDefaultRequestError,
      title: _localizer.errorMessageErrorWhileRequesting,
      canRetry: true,
    );
  }
}
```

---

## When to Add Exceptions

### ✅ Add when:
- New error type not covered (payment failure, biometric failure, session expired)
- Feature-specific error with custom UI requirements
- Distinct user action needed (retry with different params, redirect to settings)

### ❌ Don't add for:
- Minor variations → use parameters: `ServerException(statusCode: 404)` not `Server404Exception`
- Debugging → use logging
- Non-error states → use BLoC states: `State.loading()` not `LoadingException`

---

## Adding Custom Exception

**Example: PaymentFailedException**

**Step 1: Add exception class**

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
@ExceptionUiConfig(descriptionKey: 'paymentFailed')
final class PaymentFailedException extends AppException {
  const PaymentFailedException({this.paymentMethod, this.errorCode});

  final String? paymentMethod;
  final String? errorCode;

  @override
  String get name => 'PaymentFailed';

  @override
  bool get canRetry => true;
}
```

**Step 2: Add localization**

The exception keys are consumed by `UikitLocalizer`, so they live in the **uikit** package's ARB
files. English is the base locale; add the Russian translation in `intl_ru.arb` alongside it.

```json
// packages/starter_uikit/lib/l10n/intl_en.arb
{
  "paymentFailed": "Payment could not be processed. Try another payment method.",
  "insufficientFunds": "Insufficient funds",
  "cardDeclined": "Card declined"
}
```

**Step 3: Generate code**

```bash
dart run utils/generators/generate_exception_mapper.dart
fvm flutter --no-color pub global run intl_utils:generate
```

**Step 4: Throw in data source**

```dart
class ApiPaymentDataSource implements PaymentDataSource {
  @override
  Future<Payment> processPayment(PaymentRequest request) async {
    try {
      return await _client.requestJson<Payment>(
        method: HttpMethod.post,
        path: '/payments',
        body: request.toJson(),
        fromJson: Payment.fromJson,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 402) {
        throw PaymentFailedException(
          paymentMethod: request.method,
          errorCode: e.response?.data['error_code'],
        );
      }
      rethrow;
    }
  }
}
```

**Step 5: Display in UI**

`FailureWidget` maps the exception to the localized UI model internally — pass the
`AppException` itself:

```dart
BlocBuilder<PaymentBloc, PaymentState>(
  builder: (context, state) => switch (state) {
    PaymentProcessingState() => const CustomCircularProgressIndicator.adaptive(),
    PaymentFailureState(:final exception) => FailureWidget.large(
      exception: exception,
      onRetry: () => context.read<PaymentBloc>().add(const PaymentEvent.retried()),
    ),
    PaymentSuccessState(:final payment) => PaymentSuccessView(payment),
    _ => const SizedBox.shrink(),
  },
)
```

For snackbars use `NotificationSnackBar.showExceptionMessage(context, exception: exception)`.

---

## Common Patterns

### Exception with Context

```dart
@ExceptionUiConfig(descriptionKey: 'fileUploadFailed')
final class FileUploadFailedException extends AppException {
  const FileUploadFailedException({
    required this.fileName,
    required this.fileSize,
    this.reason,
  });

  final String fileName;
  final int fileSize;
  final String? reason;

  @override
  String get name => 'FileUploadFailed';

  @override
  bool get canRetry => true;
}
```

### Exception with Validation

```dart
@ExceptionUiConfig(descriptionKey: 'validationFailed')
final class ValidationFailedException extends AppException {
  const ValidationFailedException({required this.fieldErrors});

  final Map<String, String> fieldErrors;

  @override
  String get name => 'ValidationFailed';

  @override
  bool get canRetry => false;
}
```

### Exception with Retry Strategy

```dart
@ExceptionUiConfig(descriptionKey: 'rateLimitExceeded')
final class RateLimitExceededException extends AppException {
  const RateLimitExceededException({required this.retryAfter});

  final Duration retryAfter;

  @override
  String get name => 'RateLimitExceeded';

  @override
  bool get canRetry => true;
}
```

---

## Feature-Specific Mappers

Extend `ExceptionUiMapperDecorator` for custom messages. The decorator's delegation methods
(`mapPaymentFailed`, …) are generated from the `@ExceptionUiConfig` annotations:

```dart
class PaymentExceptionMapper extends ExceptionUiMapperDecorator {
  PaymentExceptionMapper(super.context, super.wrapped);

  @override
  ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
    if (errorCode == 'insufficient_funds') {
      return ExceptionUiModel.simple(
        description: UikitLocalizer.of(context).insufficientFunds,
        canRetry: false,
      );
    }
    return super.mapPaymentFailed(paymentMethod, errorCode);
  }
}
```

---

## Testing

### Test Exception

```dart
void main() {
  test('creates exception with parameters', () {
    const exception = PaymentFailedException(
      paymentMethod: 'credit_card',
      errorCode: 'insufficient_funds',
    );

    expect(exception.paymentMethod, equals('credit_card'));
    expect(exception.errorCode, equals('insufficient_funds'));
    expect(exception.canRetry, isTrue);
  });
}
```

### Test Mapper

`ExceptionUiMapper` resolves `UikitLocalizer` from the `BuildContext` in its constructor, so a
bare mock context won't work — pump a widget with the localization delegate and use its real
context:

```dart
void main() {
  testWidgets('maps exception with error code', (tester) async {
    late final ExceptionUiModel uiModel;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [UikitLocalizer.delegate],
        home: Builder(
          builder: (context) {
            uiModel = ExceptionUiMapper(context)
                .map(const PaymentFailedException(errorCode: 'card_declined'));

            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(uiModel.description, isNotEmpty);
    expect(uiModel.canRetry, isTrue);
  });
}
```
