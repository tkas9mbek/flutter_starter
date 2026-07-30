# Exception Handling

Cross-cutting call behavior (retry, caching, custom decorators) is covered in
[repository_executor.md](repository_executor.md).

## Architecture

Two-layer exception system:
- **Data Layer** (`starter_toolkit`): Pure Dart `AppException` sealed classes with `@ExceptionUiConfig` annotations
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

### UI Layer: ExceptionUiModel

```dart
class ExceptionUiModel extends Equatable {
  final String? title;
  final String description;
  final String? snackbarDescription;
  final bool canRetry;
  final bool canRefresh;

  const ExceptionUiModel({
    this.title,
    required this.description,
    this.snackbarDescription,
    this.canRetry = false,
    this.canRefresh = false,
  });

  factory ExceptionUiModel.simple({
    required String description,
    bool canRetry = false,
  }) => ExceptionUiModel(description: description, canRetry: canRetry);
}
```

### Mapper: ExceptionUiMapper

Auto-generated using switch expressions for exhaustive pattern matching:

```dart
class ExceptionUiMapper {
  final BuildContext context;
  late final UiLocalizer _localizer;

  ExceptionUiMapper(this.context) {
    _localizer = UiLocalizer.of(context);
  }

  ExceptionUiModel map(AppException exception) {
    return switch (exception) {
      NoInternetException() => mapNoInternet(),
      ServerException(statusCode: final statusCode, message: final message) =>
        mapServer(statusCode, message),
      UnauthorizedException(message: final message) => mapUnauthorized(message),
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
@ExceptionUiConfig(descriptionKey: 'paymentFailed', canRetry: true)
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

```json
// lib/l10n/intl_ru.arb
{
  "paymentFailed": "Ошибка при обработке платежа. Попробуйте другой способ оплаты.",
  "insufficientFunds": "Недостаточно средств",
  "cardDeclined": "Карта отклонена"
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

```dart
BlocBuilder<PaymentBloc, PaymentState>(
  builder: (context, state) => switch (state) {
    PaymentProcessingState() => const CircularProgressIndicator(),
    PaymentFailureState(:final exception) => Builder(
      builder: (context) {
        final uiModel = ExceptionUiMapper(context).map(exception);
        return FailureWidget.large(
          uiModel: uiModel,
          onRetry: () => context.read<PaymentBloc>().add(const PaymentEvent.retry()),
        );
      },
    ),
    PaymentSuccessState(:final payment) => PaymentSuccessView(payment),
    _ => const SizedBox.shrink(),
  },
)
```

---

## Common Patterns

### Exception with Context

```dart
@ExceptionUiConfig(descriptionKey: 'fileUploadFailed', canRetry: true)
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
@ExceptionUiConfig(descriptionKey: 'validationFailed', canRetry: false)
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
@ExceptionUiConfig(descriptionKey: 'rateLimitExceeded', canRetry: true)
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

Extend `ExceptionUiMapperDecorator` for custom messages:

```dart
class PaymentExceptionMapper extends ExceptionUiMapperDecorator {
  PaymentExceptionMapper(super.context, super.wrapped);

  @override
  ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
    if (errorCode == 'insufficient_funds') {
      return ExceptionUiModel.simple(
        description: UiLocalizer.of(context).insufficientFunds,
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

```dart
void main() {
  late ExceptionUiMapper mapper;

  setUp(() => mapper = ExceptionUiMapper(MockBuildContext()));

  test('maps exception with error code', () {
    const exception = PaymentFailedException(errorCode: 'card_declined');
    final uiModel = mapper.map(exception);

    expect(uiModel.description, isNotEmpty);
    expect(uiModel.canRetry, isTrue);
  });
}
```
