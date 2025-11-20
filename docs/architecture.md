# Architecture Guide

> **AI Context**: This document defines the architectural principles for the Flutter starter project. Follow these principles when implementing features.

## Core Principles

1. **Dependency Inversion**: Both Data and UI layers depend on Domain abstractions
2. **Testability**: Easy testing through proper abstraction and dependency injection
3. **Separation of Concerns**: Each layer has clearly defined responsibilities
4. **Simplicity**: Minimize unnecessary abstractions

---

## Three-Layer Architecture

### Dependency Flow (Dependency Inversion)

```
┌─────────────────────────────────┐
│     Presentation Layer          │
│    (BLoC, Widgets, UI)         │
└────────────┬────────────────────┘
             │ depends on
             ↓
┌─────────────────────────────────┐
│       Domain Layer              │
│  (Abstract DS, Repository)      │  ← Both layers depend on this!
└────────────┬────────────────────┘
             ↑ implements
┌────────────┴────────────────────┐
│        Data Layer               │
│    (DS Impl, ApiClient)         │
└─────────────────────────────────┘
```

**Key Insight**: Domain defines contracts (interfaces). Both Presentation and Data depend on Domain.

---

## Dependency Rules

### 1. Vertical Dependencies

**AI Instruction**: Dependencies flow toward Domain abstractions:
- **Presentation** depends on **Domain** (uses Repository, Abstract DS)
- **Data** implements **Domain** (implements Abstract DS)
- **Domain** has no dependencies (pure Dart, defines contracts)

### 2. Horizontal Dependencies

**AI Instruction**: ONLY Flutter widgets can have horizontal dependencies:
- ✅ Widgets can import other widgets
- ❌ BLoCs **cannot** depend on other BLoCs (use reactive mechanisms instead)
- ❌ Repositories **cannot** depend on other Repositories

### 3. Flutter Framework

**AI Instruction**: ONLY Presentation layer can import Flutter:
- ❌ Data Layer: No Flutter imports
- ❌ Domain Layer: No Flutter imports
- ✅ Presentation Layer: Full Flutter access

---

## Layer Responsibilities

### Domain Layer (Core)

**Location:** `lib/features/{feature}/domain/`

**Purpose:** Define contracts and business rules

**Contains:**
- **Abstract DataSources**: Contracts for data operations
- **Repositories**: Coordinate data access (usually concrete)
- **Models**: Domain data structures

```dart
// Abstract DataSource (contract)
abstract class UserDataSource {
  Future<List<User>> getUsers();
  Future<User> getUserById(String id);
}

// Repository (concrete, delegates to abstract DS)
class UserRepository {
  final UserDataSource _dataSource;
  const UserRepository(this._dataSource);

  Future<List<User>> getUsers() => _dataSource.getUsers();
  Future<User> getUserById(String id) => _dataSource.getUserById(id);
}
```

**Rules:**
- ❌ No Flutter dependencies
- ❌ No horizontal dependencies
- ✅ Pure Dart only
- ✅ Define abstractions, not implementations

---

### Data Layer

**Location:** `lib/features/{feature}/data/`

**Purpose:** Implement data contracts

**Contains:**
- **DataSource Implementations**: Remote, Local, Mock

**Note:** We use the same domain models for API responses (no separate DTOs).

```dart
// DataSource Implementation (implements Domain contract)
class RemoteUserDataSource implements UserDataSource {
  final ApiClient _client;
  const RemoteUserDataSource(this._client);

  @override
  Future<List<User>> getUsers() => _client.requestJsonList<User>(
        method: HttpMethod.get,
        path: '/users',
        fromJson: User.fromJson,
      );

  @override
  Future<User> getUserById(String id) => _client.requestJson<User>(
        method: HttpMethod.get,
        path: '/users/$id',
        fromJson: User.fromJson,
      );
}
```

**Rules:**
- ❌ No Flutter dependencies
- ✅ Implements Domain abstractions
- ✅ Handles external data operations
- ❌ No business logic
- ✅ Uses domain models (no DTOs)

---

### Presentation Layer

**Location:** `lib/features/{feature}/ui/`

**Purpose:** Display UI and manage presentation state

**Contains:**
- **BLoCs**: State management
- **Widgets**: Reusable UI components
- **Screens**: Full screen views

```dart
// BLoC (depends on Domain)
class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _repository;

  UserListBloc(this._repository) : super(const UserListState.initial()) {
    on<UserListRequested>(_onRequested);
  }

  Future<void> _onRequested(
    UserListRequested event,
    Emitter<UserListState> emit,
  ) async {
    emit(const UserListState.loading());
    try {
      final users = await _repository.getUsers();
      emit(UserListState.success(users));
    } on AppException catch (e) {
      emit(UserListState.failure(e));
    }
  }
}
```

**Rules:**
- ✅ Can depend on Domain (Repository, Abstract DS)
- ✅ Can have horizontal dependencies (widget ↔ widget)
- ❌ Cannot access Data layer directly
- ❌ Should not contain business logic

---

## Why Abstract DataSources?

**AI Instruction**: DataSources are abstract because they need flexibility:

### Multiple Implementations

```dart
// Domain defines the contract
abstract class TaskDataSource {
  Future<List<Task>> getTasks();
}

// Data provides implementations
class RemoteTaskDataSource implements TaskDataSource { ... }
class LocalTaskDataSource implements TaskDataSource { ... }
class MockTaskDataSource implements TaskDataSource { ... }

// Easy switching via DI
getIt.registerFactory<TaskDataSource>(() {
  if (env == AppEnvironment.dev) return MockTaskDataSource();
  return RemoteTaskDataSource(getIt<ApiClient>());
});
```

### Easy Testing

```dart
// Test with mock DataSource
class MockUserDataSource implements UserDataSource {
  @override
  Future<List<User>> getUsers() async => [mockUser1, mockUser2];
}

// Integration test
final mockDS = MockUserDataSource();
final repository = UserRepository(mockDS);
final bloc = UserListBloc(repository);

blocTest<UserListBloc, UserListState>(
  'emits success when users loaded',
  build: () => bloc,
  act: (bloc) => bloc.add(const UserListEvent.requested()),
  expect: () => [
    const UserListState.loading(),
    UserListState.success([mockUser1, mockUser2]),
  ],
);
```

---

## Why Concrete Repositories?

**AI Instruction**: Repositories are usually concrete because:

1. **No logic** - Just delegation to DataSource
2. **Single implementation** - Rarely need variants
3. **Simpler** - Less boilerplate

```dart
// ✅ Typical: Concrete Repository
class TaskRepository {
  final TaskDataSource _dataSource;
  const TaskRepository(this._dataSource);

  Future<List<Task>> getTasks() => _dataSource.getTasks();
  Future<Task> getTaskById(String id) => _dataSource.getTaskById(id);
}

// ❌ Unnecessary: Abstract Repository (unless you need it!)
abstract class TaskRepository {
  Future<List<Task>> getTasks();
}

class TaskRepositoryImpl implements TaskRepository { ... }
```

**Make abstract only when:**
- Multiple implementations needed (e.g., different business strategies)
- Clear value from abstraction (e.g., easier testing of complex logic)

---

## Data Flow

### Complete Request Flow

```
User Tap
    ↓
Widget → bloc.add(Event)
    ↓
BLoC → repository.getData()
    ↓
Repository → dataSource.fetch()  ← Abstract interface
    ↓
DataSource (Impl) → apiClient.request()  ← HTTP client
    ↓
API Response → Domain Model (via Freezed @JsonSerializable)
    ↓
BLoC → emit(State)
    ↓
Widget Rebuild
```

### Example

```dart
// 1. User taps button
ElevatedButton(
  onPressed: () => context.read<UserListBloc>().add(
    const UserListEvent.requested(),
  ),
)

// 2. BLoC handler
Future<void> _onRequested(event, emit) async {
  emit(const UserListState.loading());
  final users = await _repository.getUsers();  // 3. Call Repository
  emit(UserListState.success(users));          // 6. Emit state
}

// 3-5. Repository → DataSource → ApiClient → API
// (Behind the scenes using dependency inversion)

// 6. Widget rebuilds
BlocBuilder<UserListBloc, UserListState>(
  builder: (context, state) => state.when(
    loading: () => CircularProgressIndicator(),
    success: (users) => UserList(users: users),
  ),
)
```

---

## BLoC Communication

**AI Instruction**: BLoCs should not have direct dependencies on other BLoCs. Instead, use reactive mechanisms:

### ❌ Wrong - Direct BLoC Dependency

```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductBloc _productBloc;  // ❌ Direct dependency

  CartBloc(this._productBloc) {
    on<ProductAddedToCart>((event, emit) {
      final product = _productBloc.state.selectedProduct;  // ❌ Bad
      // ...
    });
  }
}
```

### ✅ Correct - Repository Communication

```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  final ProductRepository _productRepository;  // ✅ Use repositories

  CartBloc(this._cartRepository, this._productRepository) {
    on<ProductAddedToCart>((event, emit) async {
      final product = await _productRepository.getProduct(event.id);  // ✅ Good
      await _cartRepository.addItem(product);
      // ...
    });
  }
}
```

### ✅ Correct - Stream Subscription

```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;
  StreamSubscription? _productSubscription;

  CartBloc(this._repository, Stream<Product> productStream) {
    _productSubscription = productStream.listen((product) {
      add(CartEvent.productUpdated(product));  // ✅ React to events
    });
  }

  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }
}
```

---

## Exception Handling

**AI Instruction**: Use two-layer exception architecture:

### Data Layer Exceptions

**Location:** `packages/starter_toolkit/lib/data/exceptions/`

**Purpose:** Pure Dart exceptions without UI dependencies

```dart
// Domain exceptions use Freezed union types
@freezed
class AppException with _$AppException {
  @ExceptionUiConfig(
    descriptionKey: 'noInternetConnection',
    canRetry: true,
  )
  const factory AppException.noInternet() = _NoInternetAppException;

  @ExceptionUiConfig(
    descriptionKey: 'serverError',
    canRetry: true,
  )
  const factory AppException.server() = _ServerAppException;

  const AppException._();
}
```

### UI Layer Exception Models

**Location:** `packages/starter_uikit/lib/models/`

**Purpose:** UI presentation with localized messages

```dart
// UI model with BuildContext-dependent localization
class ExceptionUiModel extends Equatable {
  final String? title;
  final String description;
  final String? snackbarDescription;
  final bool canRefresh;
  final bool canRetry;
}

// Mapper converts domain exceptions to UI models
class ExceptionUiMapper {
  final BuildContext context;

  ExceptionUiModel map(AppException exception) {
    return exception.when(
      noInternet: () => ExceptionUiModel(
        description: Localizer.of(context).noInternetConnection,
        canRetry: true,
      ),
      // ... other cases
    );
  }
}
```

### Usage in BLoC

```dart
Future<void> _onRequested(event, emit) async {
  emit(const State.loading());

  try {
    final data = await _repository.getData();

    return emit(State.success(data));
  } on AppException catch (e) {
    return emit(State.failure(e));  // Store domain exception
  }
}
```

### Usage in UI

```dart
// Map to UI model in widget
state.when(
  failure: (exception) {
    final uiModel = ExceptionUiMapper(context).map(exception);
    return FailureWidgetLarge(
      uiModel: uiModel,
      onRetry: _retry,
    );
  },
)
```

**Benefits:**
- Data layer has no BuildContext dependency
- UI layer handles localization
- Extensible via decorator pattern
- Code generation reduces boilerplate

See [Exception Refactoring Guide](./exception-refactoring.md) for complete details.

---

## Repository Executors

**AI Instruction**: Use decorator pattern for cross-cutting concerns:

### Decorator Pattern

Repository executors add functionality through composition:

```dart
// Base executor - just executes function
final executor = RawRepositoryExecutor()
  .withErrorHandling()   // Converts exceptions to AppException
  .withRetry()           // Adds retry logic with backoff
  .withCaching();        // Adds time-based caching
```

### Available Decorators

**ErrorHandlingExecutor**: Normalizes all errors to AppException
```dart
ErrorHandlingExecutor(wrapped)
  // Converts DioException → AppException
  // Handles unknown errors in production
```

**RetryExecutor**: Automatic retry with exponential backoff
```dart
RetryExecutor(
  wrapped,
  maxRetries: 3,
  retryDelay: Duration(seconds: 2),
)
```

**CachingExecutor**: Time-based caching with cleanup
```dart
final executor = CachingExecutor(
  wrapped,
  defaultTtl: Duration(minutes: 5),
);

// Use with key for caching
executor.cached(
  () => _dataSource.getData(),
  key: 'data_key',
);
```

### Usage in Repository

```dart
class UserRepository {
  final UserDataSource _dataSource;
  final RepositoryExecutor _executor;

  Future<List<User>> getUsers() {
    return _executor.execute(() => _dataSource.getUsers());
  }
}

// DI setup
getIt.registerFactory<RepositoryExecutor>(() {
  return RawRepositoryExecutor()
    .withErrorHandling()
    .withRetry()
    .withCaching();
});
```

**Benefits:**
- Composable decorators
- No code duplication
- Easy to add new executors
- Memory leak prevention (cleanup timer)

See [Repository Executor Refactoring](./repository-executor-refactoring.md) for complete details.

---

## Testing Strategy

### Three Testing Layers

1. **Data Layer Unit Tests** (Required for Repositories)
   - Repository (Real) → DataSource (Mock)
   - DataSource (Real) → ApiClient (Mock)

2. **BLoC Unit Tests** (Required)
   - BLoC (Real) → Repository (Mock)
   - Test all events: success, empty, failure scenarios

3. **Integration Tests** (Recommended)
   - BLoC (Real) → Repository (Real) → DataSource (Real) → ApiClient (Mock)
   - Verify full feature flow works end-to-end

See [Testing Guide](./testing.md) for detailed examples.

---

## Related Documentation

- [Project Structure](./structure.md) - File organization
- [Testing Guide](./testing.md) - Testing strategies
- [BLoC & Freezed](./bloc_freezed.md) - BLoC patterns
- [Code Formatting](./code_formatting.md) - Code style guide
- [Naming Conventions](./naming.md) - Naming standards

---

**Last Updated**: November 18, 2025
