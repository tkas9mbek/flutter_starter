# Exception Handling Guide

> **AI Context**: Comprehensive guide to creating and using custom exceptions with code generation and localization.

## Overview

This project uses a two-layer exception architecture:
1. **Data Layer** (`packages/starter_toolkit`): Pure Dart `AppException` - Sealed classes with `@ExceptionUiConfig` annotations
2. **UI Layer** (`packages/starter_uikit`): `ExceptionUiModel` - Equatable models with localized messages

**Benefits:**
- Data layer has no BuildContext dependency (pure Dart)
- UI layer handles localization
- Extensible via decorator pattern
- Code generation reduces boilerplate
- Type-safe exception handling with exhaustive pattern matching

---

## Exception Architecture

### Data Layer: AppException

Pure Dart sealed class hierarchy without UI dependencies.

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
sealed class AppException implements Exception {
  const AppException();

  String get name;
  bool get canRetry;
}

/// No internet connection
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

/// Server error with status code and optional message
@ExceptionUiConfig(
  titleKey: 'errorMessageErrorWhileRequesting',
  descriptionKey: 'errorMessageDefaultRequestError',
)
final class ServerException extends AppException {
  const ServerException({
    required this.statusCode,
    this.message,
  });

  final int? statusCode;
  final String? message;

  @override
  String get name => 'Server';

  @override
  bool get canRetry => true;
}
```

**Key points:**
- `sealed class` enables exhaustive pattern matching
- `final class` for concrete exception types
- Parameters as final fields
- Required getters: `name` and `canRetry`

### UI Layer: ExceptionUiModel

UI models with localized messages.

```dart
// packages/starter_uikit/lib/models/exception_ui_model.dart
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

  // Simplified factory for common cases
  factory ExceptionUiModel.simple({
    required String description,
    bool canRetry = false,
  }) {
    return ExceptionUiModel(
      description: description,
      canRetry: canRetry,
    );
  }
}
```

### Mapper: ExceptionUiMapper

Converts domain exceptions to UI models with localization using switch expressions.

```dart
// packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart
class ExceptionUiMapper {
  final BuildContext context;
  late final UiLocalizer _localizer;

  ExceptionUiMapper(this.context) {
    _localizer = UiLocalizer.of(context);
  }

  // Auto-generated method using switch expression
  ExceptionUiModel map(AppException exception) {
    return switch (exception) {
      NoInternetException() => mapNoInternet(),
      ServerException(statusCode: final statusCode, message: final message) =>
        mapServer(statusCode, message),
      UnauthorizedException(message: final message) => mapUnauthorized(message),
      // ... other cases
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

**Key points:**
- Uses switch expressions for exhaustive pattern matching
- Compiler ensures all exception types are handled
- Pattern matching extracts fields from exceptions
- Protected methods allow decorator overrides

---

## When to Add Custom Exceptions

### ✅ Add new exception when:

1. **New error type** not covered by existing exceptions
   - Payment processing failure
   - Biometric authentication failure
   - File upload error
   - Session expired

2. **Feature-specific** error with custom UI requirements
   - Different error messages
   - Different user actions
   - Feature-specific recovery

3. **Distinct user action** needed
   - Retry with different parameters
   - Redirect to settings
   - Re-authenticate

### ❌ DO NOT add exception for:

- **Minor variations** of existing exceptions → use parameters instead
  ```dart
  // ✗ Don't create separate exceptions for each HTTP code
  final class Server400Exception extends AppException { }
  final class Server401Exception extends AppException { }
  final class Server404Exception extends AppException { }

  // ✓ Use parameters
  ServerException(statusCode: 400, message: '...')
  ServerException(statusCode: 401, message: '...')
  ServerException(statusCode: 404, message: '...')
  ```

- **Temporary debugging** → use logging
  ```dart
  // ✗ Don't create exceptions for debugging
  final class DebugException extends AppException { }

  // ✓ Use logger
  logger.d('Debug info: $message');
  ```

- **Non-error states** → use regular state management
  ```dart
  // ✗ Don't use exceptions for state
  final class LoadingException extends AppException { }
  final class EmptyException extends AppException { }

  // ✓ Use BLoC states
  State.loading()
  State.empty()
  ```

---

## Adding a Custom Exception

### Step-by-Step Example: PaymentFailedException

**Step 1: Add exception class to AppException**

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
sealed class AppException implements Exception {
  const AppException();

  String get name;
  bool get canRetry;
}

// ... existing exceptions

/// Payment processing failed
@ExceptionUiConfig(
  descriptionKey: 'paymentFailed',
  canRetry: true,
)
final class PaymentFailedException extends AppException {
  const PaymentFailedException({
    this.paymentMethod,
    this.errorCode,
  });

  final String? paymentMethod;
  final String? errorCode;

  @override
  String get name => 'PaymentFailed';

  @override
  bool get canRetry => true;
}
```

**Parameters guide:**
- Add parameters as final fields with optional types if not always available
- Use descriptive parameter names
- Implement required `name` and `canRetry` getters

**Step 2: Add localization keys**

```json
// lib/l10n/intl_ru.arb
{
  "paymentFailed": "Ошибка при обработке платежа. Попробуйте другой способ оплаты.",
  "paymentFailedWithCode": "Ошибка платежа: {code}",
  "tryAnotherPaymentMethod": "Попробуйте другой способ оплаты",
  "insufficientFunds": "Недостаточно средств",
  "cardDeclined": "Карта отклонена"
}
```

```json
// lib/l10n/intl_en.arb (optional)
{
  "paymentFailed": "Payment processing failed. Try another payment method.",
  "paymentFailedWithCode": "Payment error: {code}",
  "tryAnotherPaymentMethod": "Try another payment method",
  "insufficientFunds": "Insufficient funds",
  "cardDeclined": "Card declined"
}
```

**Step 3: Run code generators**

```bash
# 1. Generate exception mapper code (creates mapper methods with switch expression)
dart run tool/generate_exception_mapper.dart

# 2. Generate localization code (if you added ARB keys)
fvm flutter --no-color pub global run intl_utils:generate
```

**What gets generated:**
- `exception_ui_mapper.dart`: Updated switch expression with new case
- `exception_ui_mapper.dart`: New `mapPaymentFailed()` method
- `exception_ui_mapper_decorator.dart`: Override method
- `l10n/generated/`: Localization classes

**Generated mapper code:**
```dart
ExceptionUiModel map(AppException exception) {
  return switch (exception) {
    NoInternetException() => mapNoInternet(),
    ServerException(statusCode: final statusCode, message: final message) =>
      mapServer(statusCode, message),
    // ... other cases
    PaymentFailedException(paymentMethod: final method, errorCode: final code) =>
      mapPaymentFailed(method, code),  // NEW
  };
}

@protected
ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
  return ExceptionUiModel(
    description: _localizer.paymentFailed,
    canRetry: true,
  );
}
```

**Step 4: (Optional) Customize UI mapping**

If default annotation isn't enough, customize in generated method:

```dart
// packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart
class ExceptionUiMapper {
  // ... map() method with switch expression

  @protected
  ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
    // Custom logic based on error code
    if (errorCode != null) {
      return ExceptionUiModel(
        title: _localizer.error,
        description: _localizer.paymentFailedWithCode(errorCode),
        snackbarDescription: _localizer.tryAnotherPaymentMethod,
        canRetry: true,
        canRefresh: false,
      );
    }

    return ExceptionUiModel(
      description: _localizer.paymentFailed,
      snackbarDescription: _localizer.tryAnotherPaymentMethod,
      canRetry: true,
    );
  }
}
```

**Step 5: Throw in data source**

```dart
// lib/features/payment/data/remote_payment_data_source.dart
class RemotePaymentDataSource implements PaymentDataSource {
  final ApiClient _client;

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
      // Map HTTP errors to domain exceptions
      if (e.response?.statusCode == 402) {
        final errorCode = e.response?.data['error_code'] as String?;
        throw PaymentFailedException(
          paymentMethod: request.method,
          errorCode: errorCode,
        );
      }
      rethrow; // Let ErrorHandlingExecutor handle other errors
    }
  }
}
```

**Step 6: Catch in repository/BLoC**

```dart
// lib/features/payment/ui/bloc/payment_bloc.dart
Future<void> _onPaymentSubmitted(event, emit) async {
  emit(const PaymentState.processing());

  try {
    final payment = await _repository.processPayment(event.request);

    return emit(PaymentState.success(payment));
  } on AppException catch (e) {
    return emit(PaymentState.failure(e));
  }
}
```

**Step 7: Display in UI**

```dart
// lib/features/payment/ui/screen/payment_screen.dart
BlocBuilder<PaymentBloc, PaymentState>(
  builder: (context, state) => switch (state) {
    PaymentProcessingState() => const CircularProgressIndicator(),
    PaymentFailureState(:final exception) => Builder(
      builder: (context) {
        final uiModel = ExceptionUiMapper(context).map(exception);
        return FailureWidgetLarge(
          uiModel: uiModel,
          onRetry: () => context.read<PaymentBloc>().add(
            const PaymentEvent.retry(),
          ),
        );
      },
    ),
    PaymentSuccessState(:final payment) => PaymentSuccessView(payment),
    _ => const SizedBox.shrink(),
  },
)
```

---

## Common Exception Patterns

### 1. Exception with Additional Context

For exceptions that need extra information:

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

**Usage:**
```dart
throw FileUploadFailedException(
  fileName: file.name,
  fileSize: file.size,
  reason: 'File too large',
);
```

### 2. Exception with Validation Errors

For form validation failures:

```dart
@ExceptionUiConfig(descriptionKey: 'validationFailed', canRetry: false)
final class ValidationFailedException extends AppException {
  const ValidationFailedException({
    required this.fieldErrors,
  });

  final Map<String, String> fieldErrors;

  @override
  String get name => 'ValidationFailed';

  @override
  bool get canRetry => false;
}
```

**Usage:**
```dart
throw ValidationFailedException(
  fieldErrors: {
    'email': 'Invalid email format',
    'password': 'Password too short',
  },
);
```

**In UI with pattern matching:**
```dart
switch (exception) {
  case ValidationFailedException(:final fieldErrors):
    // Show field-specific errors
    fieldErrors.forEach((field, error) {
      showFieldError(field, error);
    });
  default:
    // Show generic error
    final uiModel = ExceptionUiMapper(context).map(exception);
    showErrorDialog(uiModel);
}
```

### 3. Exception with Retry Strategy

For rate limiting or temporary failures:

```dart
@ExceptionUiConfig(descriptionKey: 'rateLimitExceeded', canRetry: true)
final class RateLimitExceededException extends AppException {
  const RateLimitExceededException({
    required this.retryAfter,
  });

  final Duration retryAfter;

  @override
  String get name => 'RateLimitExceeded';

  @override
  bool get canRetry => true;
}
```

**Usage:**
```dart
if (response.statusCode == 429) {
  final retryAfter = response.headers['Retry-After'];
  throw RateLimitExceededException(
    retryAfter: Duration(seconds: int.parse(retryAfter ?? '60')),
  );
}
```

### 4. Exception with Multiple Actions

For exceptions with different recovery options:

```dart
@ExceptionUiConfig(
  descriptionKey: 'sessionExpired',
  canRetry: false,
  canRefresh: true,
)
final class SessionExpiredException extends AppException {
  const SessionExpiredException();

  @override
  String get name => 'SessionExpired';

  @override
  bool get canRetry => false;
}
```

**In UI with pattern matching:**
```dart
switch (exception) {
  case SessionExpiredException():
    // Navigate to login
    context.router.replace(const LoginRoute());
  default:
    final uiModel = ExceptionUiMapper(context).map(exception);
    showErrorDialog(uiModel);
}
```

---

## Feature-Specific Exception Mappers

For feature-specific error messages, extend `ExceptionUiMapperDecorator`:

### Creating a Decorator

```dart
// lib/features/payment/mappers/payment_exception_mapper.dart
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper_decorator.dart';
import 'package:starter_uikit/models/exception_ui_model.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:flutter/widgets.dart';

class PaymentExceptionMapper extends ExceptionUiMapperDecorator {
  PaymentExceptionMapper(super.context, super.wrapped);

  @override
  ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
    // Custom messages based on error code
    if (errorCode == 'insufficient_funds') {
      return ExceptionUiModel.simple(
        description: UiLocalizer.of(context).insufficientFunds,
        canRetry: false,
      );
    }

    if (errorCode == 'card_declined') {
      return ExceptionUiModel.simple(
        description: UiLocalizer.of(context).cardDeclined,
        canRetry: true,
      );
    }

    if (errorCode == 'expired_card') {
      return ExceptionUiModel(
        title: UiLocalizer.of(context).cardExpired,
        description: UiLocalizer.of(context).pleaseUpdatePaymentMethod,
        canRetry: false,
      );
    }

    // Fallback to default mapping
    return super.mapPaymentFailed(paymentMethod, errorCode);
  }

  @override
  ExceptionUiModel mapServer(int? statusCode, String? message) {
    // Custom message for payment feature
    if (statusCode == 402) {
      return ExceptionUiModel.simple(
        description: UiLocalizer.of(context).paymentRequired,
        canRetry: false,
      );
    }

    // Fallback to default
    return super.mapServer(statusCode, message);
  }
}
```

### Registering Decorator in DI

```dart
// lib/features/payment/configs/payment_module.dart
class PaymentModule extends AppModule {
  @override
  Future<void> dependencies(GetIt getIt, Environment environment) async {
    // Feature-specific exception mapper
    getIt.registerFactory<ExceptionUiMapper>(
      () => PaymentExceptionMapper(
        context, // From widget context
        ExceptionUiMapper(context),
      ),
    );

    // ... other dependencies
  }
}
```

---

## ExceptionUiConfig Reference

### All Available Parameters

```dart
@ExceptionUiConfig(
  // Required: Localization key for description
  descriptionKey: 'errorKey',

  // Optional: Localization key for title (default: 'error')
  titleKey: 'customErrorTitle',

  // Optional: Localization key for snackbar message
  snackbarKey: 'shortErrorMessage',

  // Optional: Show retry button (default: false)
  canRetry: true,

  // Optional: Show refresh button (default: false)
  canRefresh: false,
)
final class MyException extends AppException { ... }
```

### Parameter Guidelines

**descriptionKey** (required):
- Main error message shown to user
- Should be clear and actionable
- Include solution if possible

**titleKey** (optional):
- Use for custom error titles
- Default is "error" from localization
- Useful for categorizing errors

**snackbarKey** (optional):
- Shorter message for snackbars
- Should be concise (1 sentence)
- Use when full description is too long

**canRetry** (default: false):
- `true`: Show retry button for transient errors
- `false`: Error requires different action

**canRefresh** (default: false):
- `true`: Show refresh button to reload data
- `false`: Refresh won't help

---

## Testing Custom Exceptions

### Test Exception Creation

```dart
// test/data/exceptions/app_exception_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

void main() {
  group('PaymentFailedException', () {
    test('creates exception with all parameters', () {
      const exception = PaymentFailedException(
        paymentMethod: 'credit_card',
        errorCode: 'insufficient_funds',
      );

      expect(exception, isA<PaymentFailedException>());
      expect(exception.paymentMethod, equals('credit_card'));
      expect(exception.errorCode, equals('insufficient_funds'));
      expect(exception.name, equals('PaymentFailed'));
      expect(exception.canRetry, isTrue);
    });

    test('creates exception with optional parameters', () {
      const exception = PaymentFailedException();

      expect(exception.paymentMethod, isNull);
      expect(exception.errorCode, isNull);
    });
  });
}
```

### Test Exception Mapper with Switch Expression

```dart
// test/mappers/exception_ui_mapper_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

void main() {
  late ExceptionUiMapper mapper;

  setUp(() {
    // Create mapper with test context
    mapper = ExceptionUiMapper(
      MockBuildContext(), // Mock context with localization
    );
  });

  group('map with PaymentFailedException', () {
    test('maps exception with error code', () {
      const exception = PaymentFailedException(
        errorCode: 'card_declined',
      );

      final uiModel = mapper.map(exception);

      expect(uiModel.description, isNotEmpty);
      expect(uiModel.canRetry, isTrue);
    });

    test('maps exception without error code', () {
      const exception = PaymentFailedException();

      final uiModel = mapper.map(exception);

      expect(uiModel.description, isNotEmpty);
      expect(uiModel.canRetry, isTrue);
    });
  });
}
```

### Test in BLoC

```dart
// test/features/payment/bloc/payment_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late PaymentBloc bloc;
  late MockPaymentRepository mockRepository;

  setUp(() {
    mockRepository = MockPaymentRepository();
    bloc = PaymentBloc(mockRepository);
  });

  group('PaymentEvent.submitted', () {
    blocTest<PaymentBloc, PaymentState>(
      'emits failure with PaymentFailedException when payment fails',
      build: () {
        when(() => mockRepository.processPayment(any()))
            .thenThrow(const PaymentFailedException(
              errorCode: 'card_declined',
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(PaymentEvent.submitted(mockRequest)),
      expect: () => [
        const PaymentState.processing(),
        predicate<PaymentState>((state) {
          return switch (state) {
            PaymentFailureState(:final exception) =>
              exception is PaymentFailedException,
            _ => false,
          };
        }),
      ],
    );

    blocTest<PaymentBloc, PaymentState>(
      'failure state contains correct error code',
      build: () {
        when(() => mockRepository.processPayment(any()))
            .thenThrow(const PaymentFailedException(
              errorCode: 'insufficient_funds',
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(PaymentEvent.submitted(mockRequest)),
      verify: (bloc) {
        final state = bloc.state;
        if (state case PaymentFailureState(:final exception)) {
          if (exception case PaymentFailedException(:final errorCode)) {
            expect(errorCode, equals('insufficient_funds'));
          } else {
            fail('Wrong exception type');
          }
        } else {
          fail('Expected failure state');
        }
      },
    );
  });
}
```

---

## Best Practices

### 1. Use Descriptive Exception Names

```dart
// ✓ Good - Clear purpose
PaymentFailedException()
SessionExpiredException()
BiometricUnavailableException()

// ✗ Bad - Too generic
ErrorException()
FailedException()
ProblemException()
```

### 2. Add Context with Parameters

```dart
// ✓ Good - Includes useful context
FileUploadFailedException(
  fileName: 'document.pdf',
  fileSize: 1024000,
  reason: 'File too large',
)

// ✗ Bad - No context
FileUploadFailedException()
```

### 3. Use Appropriate Retry Flags

```dart
// ✓ Good - Transient error, can retry
@ExceptionUiConfig(descriptionKey: 'networkTimeout', canRetry: true)
final class TimeoutException extends AppException { ... }

// ✓ Good - Permanent error, cannot retry
@ExceptionUiConfig(descriptionKey: 'accountDeleted', canRetry: false)
final class AccountDeletedException extends AppException { ... }
```

### 4. Write Clear Localization Messages

```json
// ✓ Good - Clear, actionable
{
  "paymentFailed": "Оплата не прошла. Проверьте данные карты и попробуйте снова.",
  "sessionExpired": "Сессия истекла. Войдите в аккаунт заново."
}

// ✗ Bad - Vague, not helpful
{
  "paymentFailed": "Ошибка",
  "sessionExpired": "Что-то пошло не так"
}
```

### 5. Leverage Pattern Matching

```dart
// ✓ Good - Exhaustive pattern matching
final message = switch (exception) {
  NoInternetException() => 'Check your connection',
  ServerException(:final statusCode) => 'Server error: $statusCode',
  PaymentFailedException(:final errorCode) => 'Payment failed: $errorCode',
};

// ✓ Good - Pattern matching with extraction
if (exception case ValidationFailedException(:final fieldErrors)) {
  // Use fieldErrors directly
  for (final (field, error) in fieldErrors.entries) {
    print('$field: $error');
  }
}
```

---

## Related Documentation

- [Architecture Guide](./architecture.md) - Exception handling architecture
- [Repository Executors](./repository-executors.md) - Error handling executors
- [Testing Guide](./testing.md) - Testing strategies

---

**Last Updated**: November 20, 2025
