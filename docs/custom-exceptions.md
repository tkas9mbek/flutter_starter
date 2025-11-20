# Custom Exceptions Guide

> **AI Context**: Comprehensive guide to creating and using custom exceptions with code generation and localization.

## Overview

This project uses a two-layer exception architecture:
1. **Data Layer** (`packages/starter_toolkit`): Pure Dart `AppException` - Freezed union types with `@ExceptionUiConfig` annotations
2. **UI Layer** (`packages/starter_uikit`): `ExceptionUiModel` - Equatable models with localized messages

**Benefits:**
- Data layer has no BuildContext dependency (pure Dart)
- UI layer handles localization
- Extensible via decorator pattern
- Code generation reduces boilerplate
- Type-safe exception handling

---

## Exception Architecture

### Data Layer: AppException

Pure Dart exceptions without UI dependencies.

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
@freezed
class AppException with _$AppException {
  @ExceptionUiConfig(
    descriptionKey: 'noInternetConnection',
    canRetry: true,
  )
  const factory AppException.noInternet() = NoInternetException;

  @ExceptionUiConfig(
    descriptionKey: 'serverError',
    canRetry: true,
  )
  const factory AppException.server({
    int? statusCode,
    String? message,
  }) = ServerException;

  const AppException._();
}
```

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

Converts domain exceptions to UI models with localization.

```dart
// packages/starter_uikit/lib/mappers/exception_ui_mapper.dart
class ExceptionUiMapper {
  final BuildContext context;

  ExceptionUiMapper(this.context);

  ExceptionUiModel map(AppException exception) {
    return exception.when(
      noInternet: () => ExceptionUiModel(
        description: Localizer.of(context).noInternetConnection,
        canRetry: true,
      ),
      server: (statusCode, message) => ExceptionUiModel(
        description: message ?? Localizer.of(context).serverError,
        canRetry: true,
      ),
      // ... other cases
    );
  }
}
```

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
  AppException.server400()
  AppException.server401()
  AppException.server404()

  // ✓ Use parameters
  AppException.server(statusCode: 400, message: '...')
  ```

- **Temporary debugging** → use logging
  ```dart
  // ✗ Don't create exceptions for debugging
  AppException.debug(String message)

  // ✓ Use logger
  logger.d('Debug info: $message');
  ```

- **Non-error states** → use regular state management
  ```dart
  // ✗ Don't use exceptions for state
  AppException.loading()
  AppException.empty()

  // ✓ Use BLoC states
  State.loading()
  State.empty()
  ```

---

## Adding a Custom Exception

### Step-by-Step Example: PaymentFailedException

**Step 1: Add exception factory to AppException**

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
@freezed
class AppException with _$AppException {
  // ... existing exceptions

  /// Payment processing failed
  @ExceptionUiConfig(
    descriptionKey: 'paymentFailed',
    canRetry: true,
  )
  const factory AppException.paymentFailed({
    String? paymentMethod,
    String? errorCode,
  }) = PaymentFailedException;

  const AppException._();
}
```

**Parameters guide:**
- Add parameters for context (payment method, error code, etc.)
- Make parameters optional if not always available
- Use descriptive parameter names

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
# 1. Generate Freezed code (creates exception class)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 2. Generate exception mapper code (creates mapper methods)
dart run tool/generate_exception_mapper.dart

# 3. Generate localization code (if you added ARB keys)
fvm flutter --no-color pub global run intl_utils:generate
```

**What gets generated:**
- `app_exception.freezed.dart`: `PaymentFailedException` class
- `exception_ui_mapper.dart`: `mapPaymentFailed()` method
- `exception_ui_mapper_decorator.dart`: Override method
- `l10n/generated/`: Localization classes

**Step 4: (Optional) Customize UI mapping**

If default annotation isn't enough, customize in mapper:

```dart
// packages/starter_uikit/lib/mappers/exception_ui_mapper.dart
class ExceptionUiMapper {
  ExceptionUiModel map(AppException exception) {
    return exception.when(
      // ... other cases

      paymentFailed: (paymentMethod, errorCode) {
        // Custom logic based on error code
        return ExceptionUiModel(
          title: Localizer.of(context).error,
          description: errorCode != null
              ? Localizer.of(context).paymentFailedWithCode(errorCode)
              : Localizer.of(context).paymentFailed,
          snackbarDescription: Localizer.of(context).tryAnotherPaymentMethod,
          canRetry: true,
          canRefresh: false,
        );
      },
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
        throw AppException.paymentFailed(
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
  builder: (context, state) => state.maybeWhen(
    failure: (exception) {
      final uiModel = ExceptionUiMapper(context).map(exception);

      return FailureWidgetLarge(
        uiModel: uiModel,
        onRetry: () => context.read<PaymentBloc>().add(
          const PaymentEvent.retry(),
        ),
      );
    },
    orElse: () => const SizedBox.shrink(),
  ),
)
```

---

## Common Exception Patterns

### 1. Exception with Additional Context

For exceptions that need extra information:

```dart
@ExceptionUiConfig(descriptionKey: 'fileUploadFailed', canRetry: true)
const factory AppException.fileUploadFailed({
  required String fileName,
  required int fileSize,
  String? reason,
}) = FileUploadFailedException;
```

**Usage:**
```dart
throw AppException.fileUploadFailed(
  fileName: file.name,
  fileSize: file.size,
  reason: 'File too large',
);
```

### 2. Exception with Status Code

For API errors with HTTP status codes:

```dart
@ExceptionUiConfig(descriptionKey: 'apiError', canRetry: false)
const factory AppException.apiError({
  required int statusCode,
  String? message,
}) = ApiErrorException;
```

**Usage:**
```dart
if (response.statusCode >= 400) {
  throw AppException.apiError(
    statusCode: response.statusCode,
    message: response.data['message'],
  );
}
```

### 3. Exception with Validation Errors

For form validation failures:

```dart
@ExceptionUiConfig(descriptionKey: 'validationFailed', canRetry: false)
const factory AppException.validationFailed({
  required Map<String, String> fieldErrors,
}) = ValidationFailedException;
```

**Usage:**
```dart
throw AppException.validationFailed(
  fieldErrors: {
    'email': 'Invalid email format',
    'password': 'Password too short',
  },
);
```

**In UI:**
```dart
failure: (exception) {
  exception.maybeWhen(
    validationFailed: (fieldErrors) {
      // Show field-specific errors
      fieldErrors.forEach((field, error) {
        showFieldError(field, error);
      });
    },
    orElse: () {
      // Show generic error
      final uiModel = ExceptionUiMapper(context).map(exception);
      showErrorDialog(uiModel);
    },
  );
}
```

### 4. Exception with Retry Strategy

For rate limiting or temporary failures:

```dart
@ExceptionUiConfig(descriptionKey: 'rateLimitExceeded', canRetry: true)
const factory AppException.rateLimitExceeded({
  required Duration retryAfter,
}) = RateLimitExceededException;
```

**Usage:**
```dart
if (response.statusCode == 429) {
  final retryAfter = response.headers['Retry-After'];
  throw AppException.rateLimitExceeded(
    retryAfter: Duration(seconds: int.parse(retryAfter ?? '60')),
  );
}
```

### 5. Exception with Multiple Actions

For exceptions with different recovery options:

```dart
@ExceptionUiConfig(
  descriptionKey: 'sessionExpired',
  canRetry: false,
  canRefresh: true,
)
const factory AppException.sessionExpired() = SessionExpiredException;
```

**In UI:**
```dart
failure: (exception) {
  exception.maybeWhen(
    sessionExpired: () {
      // Navigate to login
      context.router.replace(LoginRoute());
    },
    orElse: () {
      final uiModel = ExceptionUiMapper(context).map(exception);
      showErrorDialog(uiModel);
    },
  );
}
```

---

## Feature-Specific Exception Mappers

For feature-specific error messages, extend `ExceptionUiMapperDecorator`:

### Creating a Decorator

```dart
// lib/features/payment/mappers/payment_exception_mapper.dart
import 'package:starter_uikit/mappers/exception_ui_mapper.dart';
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
        description: Localizer.of(context).insufficientFunds,
        canRetry: false,
      );
    }

    if (errorCode == 'card_declined') {
      return ExceptionUiModel.simple(
        description: Localizer.of(context).cardDeclined,
        canRetry: true,
      );
    }

    if (errorCode == 'expired_card') {
      return ExceptionUiModel(
        title: Localizer.of(context).cardExpired,
        description: Localizer.of(context).pleaseUpdatePaymentMethod,
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
        description: Localizer.of(context).paymentRequired,
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

### Using in Widget

```dart
// lib/features/payment/ui/screen/payment_screen.dart
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        state.maybeWhen(
          failure: (exception) {
            // Uses PaymentExceptionMapper from DI
            final mapper = getIt<ExceptionUiMapper>();
            final uiModel = mapper.map(exception);

            NotificationSnackBar.showError(
              context,
              message: uiModel.snackbarDescription ?? uiModel.description,
            );
          },
          orElse: () {},
        );
      },
      child: /* ... */,
    );
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
  snackbarDescriptionKey: 'shortErrorMessage',

  // Optional: Show retry button (default: false)
  canRetry: true,

  // Optional: Show refresh button (default: false)
  canRefresh: false,
)
const factory AppException.myError() = MyException;
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

**snackbarDescriptionKey** (optional):
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
      const exception = AppException.paymentFailed(
        paymentMethod: 'credit_card',
        errorCode: 'insufficient_funds',
      );

      expect(exception, isA<PaymentFailedException>());

      exception.when(
        paymentFailed: (method, code) {
          expect(method, equals('credit_card'));
          expect(code, equals('insufficient_funds'));
        },
        orElse: () => fail('Wrong exception type'),
      );
    });

    test('creates exception with optional parameters', () {
      const exception = AppException.paymentFailed();

      exception.when(
        paymentFailed: (method, code) {
          expect(method, isNull);
          expect(code, isNull);
        },
        orElse: () => fail('Wrong exception type'),
      );
    });
  });
}
```

### Test Exception Mapper

```dart
// test/mappers/exception_ui_mapper_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/mappers/exception_ui_mapper.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

void main() {
  late ExceptionUiMapper mapper;

  setUp(() {
    // Create mapper with test context
    mapper = ExceptionUiMapper(
      MockBuildContext(), // Mock context with localization
    );
  });

  group('mapPaymentFailed', () {
    test('maps exception with error code', () {
      const exception = AppException.paymentFailed(
        errorCode: 'card_declined',
      );

      final uiModel = mapper.map(exception);

      expect(uiModel.description, isNotEmpty);
      expect(uiModel.canRetry, isTrue);
    });

    test('maps exception without error code', () {
      const exception = AppException.paymentFailed();

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
            .thenThrow(const AppException.paymentFailed(
              errorCode: 'card_declined',
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(PaymentEvent.submitted(mockRequest)),
      expect: () => [
        const PaymentState.processing(),
        predicate<PaymentState>((state) => state.maybeWhen(
          failure: (exception) => exception is PaymentFailedException,
          orElse: () => false,
        )),
      ],
    );

    blocTest<PaymentBloc, PaymentState>(
      'failure state contains correct error code',
      build: () {
        when(() => mockRepository.processPayment(any()))
            .thenThrow(const AppException.paymentFailed(
              errorCode: 'insufficient_funds',
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(PaymentEvent.submitted(mockRequest)),
      verify: (bloc) {
        final state = bloc.state;
        state.maybeWhen(
          failure: (exception) {
            exception.maybeWhen(
              paymentFailed: (method, code) {
                expect(code, equals('insufficient_funds'));
              },
              orElse: () => fail('Wrong exception type'),
            );
          },
          orElse: () => fail('Expected failure state'),
        );
      },
    );
  });
}
```

### Test Custom Mapper

```dart
// test/features/payment/mappers/payment_exception_mapper_test.dart
void main() {
  late PaymentExceptionMapper mapper;
  late MockExceptionUiMapper mockWrapped;

  setUp(() {
    mockWrapped = MockExceptionUiMapper();
    mapper = PaymentExceptionMapper(mockContext, mockWrapped);
  });

  test('returns custom message for insufficient funds', () {
    const exception = AppException.paymentFailed(
      errorCode: 'insufficient_funds',
    );

    final result = mapper.mapPaymentFailed('credit_card', 'insufficient_funds');

    expect(result.description, contains('недостаточно средств'));
    expect(result.canRetry, isFalse);
  });

  test('falls back to wrapped mapper for unknown error codes', () {
    when(() => mockWrapped.mapPaymentFailed(any(), any()))
        .thenReturn(ExceptionUiModel.simple(description: 'default'));

    final result = mapper.mapPaymentFailed('credit_card', 'unknown_error');

    verify(() => mockWrapped.mapPaymentFailed('credit_card', 'unknown_error')).called(1);
    expect(result.description, equals('default'));
  });
}
```

---

## Best Practices

### 1. Use Descriptive Exception Names

```dart
// ✓ Good - Clear purpose
AppException.paymentFailed()
AppException.sessionExpired()
AppException.biometricUnavailable()

// ✗ Bad - Too generic
AppException.error()
AppException.failed()
AppException.problem()
```

### 2. Add Context with Parameters

```dart
// ✓ Good - Includes useful context
AppException.fileUploadFailed(
  fileName: 'document.pdf',
  fileSize: 1024000,
  reason: 'File too large',
)

// ✗ Bad - No context
AppException.fileUploadFailed()
```

### 3. Use Appropriate Retry Flags

```dart
// ✓ Good - Transient error, can retry
@ExceptionUiConfig(descriptionKey: 'networkTimeout', canRetry: true)
AppException.timeout()

// ✓ Good - Permanent error, cannot retry
@ExceptionUiConfig(descriptionKey: 'accountDeleted', canRetry: false)
AppException.accountDeleted()
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

### 5. Group Related Exceptions

```dart
// ✓ Good - Related authentication exceptions
AppException.sessionExpired()
AppException.invalidCredentials()
AppException.accountLocked()
AppException.biometricFailed()

// ✗ Bad - Scattered, inconsistent
AppException.sessionExpired()
AppException.wrongPassword()
AppException.lockedAccount()
AppException.touchIdError()
```

---

## Related Documentation

- [Architecture Guide](./architecture.md) - Exception handling architecture
- [Repository Executors](./repository-executors.md) - Error handling executors
- [Testing Guide](./testing.md) - Testing strategies

---

**Last Updated**: November 20, 2025
