# Migration Guide: Repository Executors & Exception Handling

> **Status**: In Progress - Migration partially complete
> **Date**: November 18, 2025

This document provides step-by-step instructions for completing the migration to the new repository executor pattern and two-layer exception handling architecture.

---

## Table of Contents

1. [Context & Overview](#context--overview)
2. [What's Been Completed](#whats-been-completed)
3. [Remaining Migration Tasks](#remaining-migration-tasks)
4. [Step-by-Step Migration Guide](#step-by-step-migration-guide)
5. [Testing After Migration](#testing-after-migration)
6. [Rollback Instructions](#rollback-instructions)

---

## Context & Overview

### What Changed

**Repository Executors** (Old → New):
- ❌ **Old**: `DefaultRepositoryExecutor`, `RetriableRepositoryExecutor`, `CachingRepositoryExecutor`
- ✅ **New**: Decorator pattern - `RawRepositoryExecutor().withErrorHandling().withRetry().withCaching()`

**Exception Handling** (Old → New):
- ❌ **Old**: `ServerException`, `NoInternetException`, etc. with `BuildContext` extensions
- ✅ **New**: Two-layer architecture:
  - **Data Layer**: `AppException` (Freezed, pure Dart) in `starter_toolkit`
  - **UI Layer**: `ExceptionUiModel` (Equatable, localized) in `starter_uikit`

### Why These Changes

1. **Decorator Pattern**: More composable, easier to extend without modifying existing code
2. **Two-Layer Exceptions**: Decouples data layer from UI, enables feature-specific error messages
3. **Code Generation**: Reduces boilerplate when adding new exceptions
4. **Better Localization**: All exception messages in `starter_uikit` ARB files

### File Structure

```
packages/starter_toolkit/lib/data/
├── exceptions/
│   ├── annotations.dart              # @ExceptionUiConfig annotation
│   ├── app_exception.dart            # Freezed union (pure Dart)
│   ├── app_exception.freezed.dart    # Generated Freezed code
│   └── app_exception_factory.dart    # Creates exceptions from HTTP responses
└── repository_executor/
    ├── repository_executor.dart      # Base class + exports
    ├── raw_repository_executor.dart  # Base executor
    ├── error_handling_executor.dart  # Normalizes errors to AppException
    ├── retry_executor.dart           # Retry with exponential backoff
    ├── caching_executor.dart         # Time-based caching
    ├── repository_executor_decorator.dart         # Base decorator
    └── repository_executor_extensions.dart        # Fluent API (.withRetry(), etc.)

packages/starter_uikit/lib/
├── models/
│   └── exception_ui_model.dart       # UI presentation model (Equatable)
├── utils/mappers/
│   ├── exception_ui_mapper.dart      # Maps AppException → ExceptionUiModel
│   └── exception_ui_mapper_decorator.dart  # For feature-specific customization
└── l10n/
    └── intl_ru.arb                   # All exception messages

tool/
└── generate_exception_mapper.dart    # Code generator for mapper methods
```

---

## What's Been Completed

### ✅ Infrastructure

1. **Created new exception architecture**:
   - `AppException` with Freezed union types and `@ExceptionUiConfig` annotations
   - `ExceptionUiModel` for UI presentation
   - `ExceptionUiMapper` and decorator for extensibility
   - Manual Freezed boilerplate (`app_exception.freezed.dart`)

2. **Created new repository executors**:
   - `RawRepositoryExecutor` - base executor
   - `ErrorHandlingExecutor` - normalizes all errors to `AppException`
   - `RetryExecutor` - retry logic with exponential backoff
   - `CachingExecutor` - time-based caching with cleanup
   - Extension methods for fluent chaining

3. **Created code generator**:
   - `tool/generate_exception_mapper.dart` - parses annotations and generates mapper methods
   - Documentation and usage instructions added

4. **Updated localization**:
   - Moved all exception messages from `starter_toolkit` to `starter_uikit`
   - Generated new localizations

5. **Updated DI modules**:
   - `lib/core/di/data_module.dart` - uses new executors
   - `lib/features/task/configs/task_module.dart` - uses new executors with caching

6. **Updated documentation**:
   - `CLAUDE.md` - added exception handling and repository executor sections
   - `docs/architecture.md` - added complete sections on both patterns
   - Removed old refactoring docs

7. **Deleted old files**:
   - Old exception implementations (`development_error.dart`, `no_internet_exception.dart`, etc.)
   - Old repository executors (`deafult_repository_executor.dart`, etc.)
   - Duplicate exception files (`auth_exception.dart`, `rights_exception.dart`, `server_500_exception.dart`)

### ⚠️ Known Issues

1. **Build Runner Compatibility**: Dart SDK 3.8.0 is incompatible with analyzer 7.7.1 and dart_style 3.1.x, preventing automatic Freezed code generation
2. **Manual Freezed File**: Created `app_exception.freezed.dart` manually as workaround
3. **Remaining Errors**: 23 analyzer errors remain (see below)

---

## Remaining Migration Tasks

### 🔴 Critical (Blocks App Functionality)

1. **Update old interceptor** (`packages/starter_toolkit/lib/data/interceptor/app_error_interceptor.dart`):
   - Currently references deleted `NoInternetException`, `ServerException`
   - **Action**: Update to use new `AppException` factories

2. **Update URL launcher helper** (`packages/starter_toolkit/lib/utils/helpers/url_launcher_helper.dart`):
   - References deleted `UrlLaunchException`
   - **Action**: Use `AppException.urlLaunchFailed()`

3. **Update failure widgets** (`packages/starter_uikit/lib/widgets/status/failure_widget.dart`):
   - Calls `exception.getDescription()` and `exception.canRefresh` (don't exist)
   - **Action**: Use `ExceptionUiMapper` to convert to `ExceptionUiModel`

4. **Update notification snackbar** (`packages/starter_uikit/lib/widgets/notification/notification_snack_bar.dart`):
   - Calls `exception.getDescription()` (doesn't exist)
   - **Action**: Use `ExceptionUiMapper` to convert to `ExceptionUiModel`

### 🟡 Important (Breaks Tests)

5. **Update test files**:
   - `test/auth/bloc/auth_bloc_test.dart` - references `RetriableRepositoryExecutor`
   - `test/auth/bloc/login_bloc_test.dart` - references `RetriableRepositoryExecutor`
   - **Action**: Update to use new decorator pattern

### 🟢 Optional (Code Cleanup)

6. **Remove old exception messages from toolkit** (`packages/starter_toolkit/lib/l10n/intl_ru.arb`):
   - Messages now duplicated in uikit
   - **Action**: Clean up once migration verified working

---

## Step-by-Step Migration Guide

### Step 1: Update Interceptor

**File**: `packages/starter_toolkit/lib/data/interceptor/app_error_interceptor.dart`

**Current Code** (❌ Broken):
```dart
import 'package:starter_toolkit/data/exceptions/no_internet_exception.dart';
import 'package:starter_toolkit/data/exceptions/server_exception.dart';

// In onError handler:
if (error.type == DioExceptionType.connectionError) {
  return NoInternetException();
} else {
  throw ServerException(statusCode: response?.statusCode);
}
```

**New Code** (✅ Working):
```dart
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

// In onError handler:
if (error.type == DioExceptionType.connectionError) {
  return const AppException.noInternet();
} else {
  return AppException.server(
    statusCode: response?.statusCode,
    message: response?.data?['message'],
  );
}
```

### Step 2: Update URL Launcher Helper

**File**: `packages/starter_toolkit/lib/utils/helpers/url_launcher_helper.dart`

**Current Code** (❌ Broken):
```dart
import 'package:starter_toolkit/data/exceptions/url_launch_exception.dart';

throw UrlLaunchException();
```

**New Code** (✅ Working):
```dart
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

throw const AppException.urlLaunchFailed();
```

### Step 3: Update Failure Widgets

**File**: `packages/starter_uikit/lib/widgets/status/failure_widget.dart`

**Current Code** (❌ Broken):
```dart
// Direct access to exception properties
Text(exception.getDescription(context))
if (exception.canRefresh) ...
```

**New Code** (✅ Working):
```dart
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

// In widget build method:
Widget build(BuildContext context) {
  final uiModel = ExceptionUiMapper(context).map(exception);

  return Column(
    children: [
      if (uiModel.title != null) Text(uiModel.title!),
      Text(uiModel.description),
      if (uiModel.canRefresh)
        TextButton(
          onPressed: onRefresh,
          child: Text('Refresh'),
        ),
      if (uiModel.canRetry)
        TextButton(
          onPressed: onRetry,
          child: Text('Retry'),
        ),
    ],
  );
}
```

**Pattern for Both `FailureWidgetLarge` and `FailureWidgetSmall`**:
1. Add import: `import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';`
2. At top of `build()`: `final uiModel = ExceptionUiMapper(context).map(exception);`
3. Replace `exception.getDescription(context)` → `uiModel.description`
4. Replace `exception.getTitle(context)` → `uiModel.title`
5. Replace `exception.canRefresh` → `uiModel.canRefresh`
6. Replace `exception.canRetry` → `uiModel.canRetry`

### Step 4: Update Notification SnackBar

**File**: `packages/starter_uikit/lib/widgets/notification/notification_snack_bar.dart`

**Current Code** (❌ Broken):
```dart
NotificationSnackBar.error(
  context: context,
  message: exception.getDescription(context),
)
```

**New Code** (✅ Working):
```dart
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

final uiModel = ExceptionUiMapper(context).map(exception);
NotificationSnackBar.error(
  context: context,
  message: uiModel.snackbarDescription ?? uiModel.description,
)
```

### Step 5: Update Test Files

**Files**:
- `test/auth/bloc/auth_bloc_test.dart`
- `test/auth/bloc/login_bloc_test.dart`

**Current Code** (❌ Broken):
```dart
import 'package:starter_toolkit/data/repository_executor/retriable_repository_executor.dart';

final executor = const RetriableRepositoryExecutor();
```

**New Code** (✅ Working):
```dart
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

final executor = RawRepositoryExecutor()
    .withErrorHandling()
    .withRetry(maxRetries: 3);
```

### Step 6: Run Code Generator (If Adding New Exceptions)

**Only needed when modifying `AppException` factories**

```bash
# 1. Add new factory to app_exception.dart with @ExceptionUiConfig
@ExceptionUiConfig(
  descriptionKey: 'myNewError',
)
const factory AppException.myNewError() = _MyNewErrorAppException;

# 2. Add localization to packages/starter_uikit/lib/l10n/intl_ru.arb
"myNewError": "Произошла новая ошибка"

# 3. Run generator
dart run tool/generate_exception_mapper.dart

# 4. Generate localizations
fvm flutter --no-color pub global run intl_utils:generate

# 5. Format code
dart format .

# 6. Run build_runner (if possible - currently has compatibility issues)
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Testing After Migration

### Quick Verification

1. **Run analyzer**:
   ```bash
   fvm flutter analyze
   ```
   Expected: 0 errors (currently 23)

2. **Run tests**:
   ```bash
   fvm flutter test
   ```

3. **Manual testing checklist**:
   - [ ] Login with wrong credentials (should show auth error)
   - [ ] Turn off internet and try to load data (should show no internet error)
   - [ ] Test error states in different features
   - [ ] Verify error messages are in Russian
   - [ ] Test retry functionality
   - [ ] Test refresh functionality

### Common Issues

**Issue**: `The method 'when' isn't defined for the type 'AppException'`
- **Cause**: Freezed code not generated properly
- **Fix**: Check `app_exception.freezed.dart` exists and is valid

**Issue**: `The method 'getDescription' isn't defined`
- **Cause**: Widget still using old exception API
- **Fix**: Update widget to use `ExceptionUiMapper` (see Step 3)

**Issue**: Localization keys not found
- **Cause**: Localizations not regenerated
- **Fix**: Run `fvm flutter --no-color pub global run intl_utils:generate`

---

## Rollback Instructions

**If migration causes critical issues:**

### Quick Rollback (Git)

```bash
# Revert to previous commit
git log --oneline -10  # Find commit before migration
git revert <commit-hash>

# Or reset (loses uncommitted work!)
git reset --hard <commit-before-migration>
```

### Manual Rollback Steps

1. **Restore old repository executors**:
   - Recreate `DefaultRepositoryExecutor`, `RetriableRepositoryExecutor`, `CachingRepositoryExecutor`
   - Revert DI modules to use old executors

2. **Restore old exception classes**:
   - Recreate `ServerException`, `NoInternetException`, etc.
   - Restore `BuildContext` extension methods

3. **Revert widget changes**:
   - Remove `ExceptionUiMapper` usage
   - Restore direct exception method calls

---

## Current Analyzer Errors (23 total)

### By File:

**app_exception.dart** (1):
- `when` method not defined (Freezed issue)

**app_error_interceptor.dart** (4):
- References deleted `no_internet_exception.dart`, `server_exception.dart`
- Calls deleted constructors

**retry_executor.dart** (1):
- `maybeWhen` not defined (Freezed issue)

**url_launcher_helper.dart** (2):
- References deleted `url_launch_exception.dart`
- Calls deleted constructor

**exception_ui_mapper.dart** (1):
- `when` not defined (Freezed issue)

**failure_widget.dart** (4):
- `getDescription()` not defined
- `canRefresh` getter not defined

**notification_snack_bar.dart** (1):
- `getDescription()` not defined

**Test files** (9):
- References deleted `retriable_repository_executor.dart`
- Uses old executor constructors

---

## Next Steps (Priority Order)

1. **Fix Freezed issues** - Either fix build_runner compatibility or verify manual `.freezed.dart` file is correct
2. **Update interceptor** - Critical for error handling
3. **Update widgets** - Critical for UI error display
4. **Update tests** - Important for verification
5. **Clean up old localization** - Optional cleanup

---

## Useful Commands

```bash
# Check current errors
fvm flutter analyze 2>&1 | grep -E "^  error" | wc -l

# List all errors
fvm flutter analyze 2>&1 | grep -E "^  error"

# Run code generator
dart run tool/generate_exception_mapper.dart

# Generate localizations
fvm flutter --no-color pub global run intl_utils:generate

# Format code
dart format .

# Run tests
fvm flutter test

# Run specific test file
fvm flutter test test/auth/bloc/login_bloc_test.dart
```

---

**Last Updated**: November 18, 2025
