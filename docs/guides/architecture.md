# Architecture Guide

## Core Principles

1. **Dependency Inversion (Data → Domain only)**: Data implements the abstract `*DataSource`
   contracts Domain defines. Presentation depends on Domain's concrete Repositories directly — that
   edge is an ordinary downward dependency, not an inverted one (see "Why Concrete Repositories?")
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
│  (Abstract DS, Repository)      │  ← Data implements the abstract DS here;
└────────────┬────────────────────┘    Presentation calls the concrete Repository
             ↑ implements
┌────────────┴────────────────────┐
│        Data Layer               │
│    (DS Impl, ApiClient)         │
└─────────────────────────────────┘
```

**Key Insight**: Domain defines the abstract `*DataSource` contract that Data implements (the
inverted edge), and hosts the concrete Repository that Presentation calls directly (an ordinary
downward dependency — see "Why Concrete Repositories?").

---

## Dependency Rules

### 1. Vertical Dependencies

Dependencies flow toward Domain abstractions:
- **Presentation** depends on **Domain** (uses Repository, Abstract DS)
- **Data** implements **Domain** (implements Abstract DS)
- **Domain** has no dependencies (pure Dart, defines contracts)

### 2. Horizontal Dependencies

ONLY Flutter widgets can have horizontal dependencies:
- ✅ Widgets can import other widgets
- ❌ BLoCs **cannot** depend on other BLoCs (use reactive mechanisms instead)
- ❌ Repositories **cannot** depend on other Repositories

### 3. Flutter Framework

ONLY Presentation layer can import Flutter:
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

// Repository (concrete, delegates to abstract DS through a RepositoryExecutor)
class UserRepository {
  const UserRepository(this._executor, this._dataSource);

  final RepositoryExecutor _executor;
  final UserDataSource _dataSource;

  Future<List<User>> getUsers() => _executor.execute(_dataSource.getUsers);
  Future<User> getUserById(String id) =>
      _executor.execute(() => _dataSource.getUserById(id));
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
- **DataSource Implementations**: `Api*` (REST), `Local*`/`Secure*`, and offline `Mock*` twins in `data/mock/` ([mocking.md](./mocking.md))

**Note:** We use the same domain models for API responses (no separate DTOs).

```dart
// DataSource Implementation (implements Domain contract)
class ApiUserDataSource implements UserDataSource {
  final ApiClient _client;
  const ApiUserDataSource(this._client);

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

**Layout:** `ui/` contains only subfeature folders (`ui/{subfeature}/{bloc,screen,widget}`) — never
`bloc/`, `screen/`, or `widget/` at its root. Single-flow features use one subfeature named after the
feature (e.g. `profile/ui/overview/`).

**Contains:**
- **BLoCs**: State management
- **Widgets**: Reusable UI components
- **Screens**: Full screen views

```dart
// BLoC (depends on Domain). Event case classes are private, states public.
class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _repository;

  UserListBloc(this._repository) : super(const UserListState.initial()) {
    on<_RequestedUserListEvent>(_onRequested);
  }

  Future<void> _onRequested(
    _RequestedUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(const UserListState.loading());

    try {
      final users = await _repository.getUsers();

      return emit(UserListState.success(users));
    } on AppException catch (e) {
      return emit(UserListState.failure(e));
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

DataSources are abstract because they need flexibility:

### Multiple Implementations

```dart
// Domain defines the contract
abstract class TaskDataSource {
  Future<List<Task>> getTasks();
}

// Data provides implementations
class ApiTaskDataSource implements TaskDataSource { ... }   // REST
class MockTaskDataSource implements TaskDataSource { ... }  // offline twin (data/mock/)

// Chosen in the feature's DI module (lib/core/di/mock_or_prod.dart)
getIt.registerFactory<TaskDataSource>(
  mockOrProd(
    mock: () => MockTaskDataSource(getIt<MockNetworkBehavior>()),
    prod: () => ApiTaskDataSource(getIt<ApiClient>()),
  ),
);
```

### Easy Testing

Feature-flow tests wire the real twin — no hand-written fakes:

```dart
final repository = TaskRepository(
  const RawRepositoryExecutor().withErrorHandling(),
  MockTaskDataSource(const MockNetworkBehavior.instant()),
);
final bloc = TasksListBloc(repository); // real bloc → real repo → real twin
```

See [testing.md](./testing.md) §5.4.

---

## Why Concrete Repositories?

Repositories are usually concrete because:

1. **No logic** - Just delegation to DataSource through the executor
2. **Single implementation** - Rarely need variants
3. **Simpler** - Less boilerplate

```dart
// ✅ Typical: Concrete Repository
class TaskRepository {
  const TaskRepository(this._executor, this._dataSource);

  final RepositoryExecutor _executor;
  final TaskDataSource _dataSource;

  Future<List<Task>> getTasks() => _executor.execute(_dataSource.getTasks);
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
API Response → Domain Model (Freezed + json_serializable `fromJson`)
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

  return emit(UserListState.success(users));   // 6. Emit state
}

// 3-5. Repository → DataSource → ApiClient → API
// (Behind the scenes using dependency inversion)

// 6. Widget rebuilds — pattern-match on the sealed state
BlocBuilder<UserListBloc, UserListState>(
  builder: (context, state) => switch (state) {
    SuccessUserListState(:final users) => UserList(users: users),
    _ => CircularProgressIndicator(),
  },
)
```

---

## BLoC Communication

BLoCs should not have direct dependencies on other BLoCs. Instead, use reactive mechanisms:

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

Use two-layer exception architecture:

### Data Layer Exceptions

`AppException` is a `sealed` hierarchy in `packages/starter_toolkit/lib/data/exceptions/` (pure Dart, `name`,
`canRetry`); each subtype carries `@ExceptionUiConfig(titleKey:, descriptionKey:, snackbarKey:)`.

### UI Layer Exception Models

`ExceptionUiModel` (`packages/starter_uikit/lib/models/`) is the presentation data; `ExceptionUiMapper` (generated
`switch` over `AppException` in `starter_uikit/lib/utils/mappers/`) converts one to the other using `UikitLocalizer`.
Never hand-edit the mapper — see [exception_handling.md](./exception_handling.md).

### Usage in BLoC

Catch `AppException` in the handler and store it in the `failure` state (see the BLoC example above and [freezed_bloc.md](./freezed_bloc.md)).

### Usage in UI

```dart
// FailureWidget maps the exception internally — pass the AppException itself
if (state case FailureMyState(:final exception)) {
  return FailureWidget.large(
    exception: exception,
    onRetry: _retry,
  );
}
```

**Benefits:**
Data has no `BuildContext` dependency; the UI layer localizes. See [Exception Handling Guide](./exception_handling.md) for step-by-step instructions on adding new exceptions.

---

## Repository Executors

Use decorator pattern for cross-cutting concerns.

Repository executors add functionality through composition, built in the DI
module closure from a single local `base` and injected via constructor params:

```dart
final base = const RawRepositoryExecutor()
  .withErrorHandling()   // Converts exceptions to AppException (innermost)
  .withRetry();          // Adds retry logic with backoff
```

**Built-in executors:**
- `RawRepositoryExecutor` - Base executor
- `ErrorHandlingExecutor` - Normalizes errors to AppException
- `RetryExecutor` - Automatic retry with exponential backoff

Caching is the `RepositoryCache` collaborator (`InMemoryRepositoryCache`), a
sibling dependency rather than a decorator.

See [Repository Executors Guide](./repository_executor.md) for step-by-step instructions on creating custom executors.

---

## Testing Strategy

Testing is mock-first: the feature-flow slice over the shipping `Mock*DataSource` is the
backbone. See the [Testing Guide](./testing.md) for the full policy; in summary:

1. **BLoC Unit Tests** (required per bloc)
   - BLoC (Real) → Repository (Mock)
   - Cover success, empty, and failure per event; failures via an immediately-throwing repo

2. **Feature-Flow / Integration Tests** (mandatory per feature)
   - BLoC (Real) → Repository (Real) → `Mock*DataSource` (Real) — nothing stubbed
   - Happy path plus one failure-state assertion

3. **Central tests** (once, app-wide)
   - Repository executor (error mapping / retry / cache) in `starter_toolkit`
   - DI graph smoke test (`test/core/di_graph_test.dart`)
   - API-DS contract tests with a mocked `ApiClient`, exercising the real `fromJson`/`toJson`

**No per-repository unit tests** — a repo is a thin facade; its delegation is proven by the feature-flow test.

---

## Related Documentation

- [Project Structure](./structure.md) - File organization
- [Testing Guide](./testing.md) - Testing strategies
- [BLoC & Freezed](./freezed_bloc.md) - BLoC patterns
- [Code Standards](../rules/code_standards.md) - Code style guide
- [Naming Conventions](../rules/naming.md) - Naming standards
