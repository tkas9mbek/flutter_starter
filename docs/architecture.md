# Architecture Guide

> **AI Context**: This document defines the architectural principles and patterns for the Flutter starter project. Follow these principles when implementing features.

## Table of Contents

1. [Architecture Goals](#architecture-goals)
2. [Layer Overview](#layer-overview)
3. [Dependency Rules](#dependency-rules)
4. [Dependency Inversion Principle](#dependency-inversion-principle)
5. [Layer Responsibilities](#layer-responsibilities)
6. [Data Flow](#data-flow)
7. [Testing Strategy](#testing-strategy)

---

## Architecture Goals

- **Simplicity**: Minimize abstractions and layers to simplify development
- **Testability**: Enable easy testing through proper abstraction and dependency injection
- **Separation of Concerns**: Each layer has clearly defined, independent responsibilities
- **Flexibility**: Allow easy switching between different data sources through abstraction
- **Maintainability**: Clear dependency rules make the codebase easy to understand and modify

---

## Layer Overview

The application follows a three-layer architecture with strict dependency rules:

```
┌─────────────────────────────────────┐
│        Presentation Layer           │
│  (UI, BLoC, Widgets, Screens)      │
└──────────────┬──────────────────────┘
               │ depends on
               ↓
┌─────────────────────────────────────┐
│         Domain Layer                │
│    (Repository, Abstract DS)        │
└──────────────┬──────────────────────┘
               │ depends on
               ↓
┌─────────────────────────────────────┐
│          Data Layer                 │
│  (DataSource Impl, Services, DTOs) │
└─────────────────────────────────────┘
```

**Visual Diagram:**

```
--------------------------- Data Layer
            {DS}
            (Service)
------------  |  ---------- Domain Layer
        {Abstract DS}
              ↑
         {Repository}
------------  ↑  ---------- Presentation Layer
           {BLoC}
              ↑
          {Flutter} ↔ {Flutter}
```

---

## Dependency Rules

### 1. Vertical Dependencies

Dependencies flow **downward** only:
- **Presentation** depends on **Domain**
- **Domain** depends on **Data** (only abstractions)
- **Data** depends on nothing (except external libraries)

### 2. Horizontal Dependencies

**ONLY** Flutter widgets (Presentation Layer) can have horizontal dependencies:
- Widgets can import and use other widgets
- BLoCs **cannot** depend on other BLoCs
- Repositories **cannot** depend on other Repositories

### 3. Flutter Framework Dependency

**ONLY** the Presentation Layer can depend on Flutter framework:
- Data Layer: No Flutter imports
- Domain Layer: No Flutter imports
- Presentation Layer: Full Flutter access

---

## Dependency Inversion Principle

The architecture follows the **Dependency Inversion Principle** to achieve flexibility and testability.

### DataSource Abstraction

**Abstract DataSources** enable:
- Easy testing by mocking data sources
- Flexibility to switch between implementations (Remote, Local, Cache)
- Clear contracts for data operations

```dart
// Domain Layer - Abstract DataSource
abstract class UserDataSource {
  Future<List<User>> getUsers();
  Future<User> getUserById(String id);
}

// Data Layer - Remote Implementation
class RemoteUserDataSource implements UserDataSource {
  final UserService service;

  RemoteUserDataSource(this.service);

  @override
  Future<List<User>> getUsers() => service.fetchUsers();

  @override
  Future<User> getUserById(String id) => service.fetchUser(id);
}

// Data Layer - Local Implementation
class LocalUserDataSource implements UserDataSource {
  final Database database;

  LocalUserDataSource(this.database);

  @override
  Future<List<User>> getUsers() => database.query('users');

  @override
  Future<User> getUserById(String id) => database.queryById('users', id);
}
```

### Repository Implementation

**Repositories are concrete classes** (not abstract) because:
- They contain **no business logic**, only facade patterns
- They coordinate between different data sources
- Single implementation is sufficient in most cases
- Creating abstractions for every repository adds unnecessary complexity

**When to make Repository abstract:**
- Multiple implementations needed (e.g., MockRepository for testing large features)
- Complex switching logic between different data strategies
- Reduces development time when abstraction provides clear value

```dart
// Domain Layer - Concrete Repository (typical case)
class UserRepository {
  final UserDataSource _dataSource;

  const UserRepository(this._dataSource);

  Future<List<User>> getUsers() => _dataSource.getUsers();
  Future<User> getUserById(String id) => _dataSource.getUserById(id);
}

// Domain Layer - Abstract Repository (special cases only)
abstract class ComplexFeatureRepository {
  Future<Data> getData();
  Future<void> saveData(Data data);
}

// Multiple implementations when needed
class RemoteComplexFeatureRepository implements ComplexFeatureRepository { ... }
class LocalComplexFeatureRepository implements ComplexFeatureRepository { ... }
```

### Why This Approach?

**Abstract DataSources:**
- ✅ Frequently need different implementations (Remote, Local, Mock)
- ✅ Testing requires easy mocking
- ✅ Real-world apps often combine multiple data sources

**Concrete Repositories:**
- ✅ Rarely need multiple implementations
- ✅ Contain no logic, just delegation
- ✅ Reduces file count and boilerplate
- ✅ Easier to maintain and understand
- ⚠️ Make abstract only when clear benefit exists

---

## Layer Responsibilities

### Presentation Layer

**Location:** `lib/features/{feature}/ui/`

**Responsibilities:**
- Display UI components and screens
- Handle user interactions
- Manage UI state through BLoC
- Navigate between screens
- Display loading, error, and success states

**Key Components:**
- **Widgets**: Reusable UI components
- **Screens**: Full screen views with routes
- **BLoCs**: State management and business logic coordination

**Rules:**
- Can depend on Domain Layer (Repository, Abstract DS)
- Can have horizontal dependencies (widget ↔ widget)
- Should **not** contain business logic (delegate to BLoC)
- Should **not** directly access Data Layer

**Example:**
```dart
// Presentation: BLoC
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
    } catch (e) {
      emit(UserListState.failure(e));
    }
  }
}
```

### Domain Layer

**Location:** `lib/features/{feature}/domain/`, `lib/features/{feature}/data/` (abstract classes)

**Responsibilities:**
- Define data contracts through abstract classes
- Provide repository implementations for coordinating data access
- Define domain models

**Key Components:**
- **Abstract DataSources**: Contracts for data operations
- **Repositories**: Concrete implementations (usually) coordinating data access
- **Models**: Domain data structures

**Rules:**
- No Flutter framework dependencies
- No horizontal dependencies
- Should be pure Dart code
- Repositories delegate to Abstract DataSources

**Example:**
```dart
// Domain: Abstract DataSource
abstract class UserDataSource {
  Future<List<User>> getUsers();
}

// Domain: Repository (concrete)
class UserRepository {
  final UserDataSource _dataSource;

  const UserRepository(this._dataSource);

  Future<List<User>> getUsers() => _dataSource.getUsers();
}
```

### Data Layer

**Location:** `lib/features/{feature}/data/`

**Responsibilities:**
- Implement abstract data sources
- Handle API calls and data serialization
- Manage local storage operations
- Transform DTOs to domain models

**Key Components:**
- **DataSource Implementations**: Concrete implementations (Remote, Local)
- **Services**: API clients (often using Retrofit)
- **DTOs**: Data transfer objects for API communication

**Rules:**
- No Flutter framework dependencies
- Implements Domain Layer abstractions
- Handles all external data operations
- Should not contain business logic

**Example:**
```dart
// Data: Service (Retrofit API)
@RestApi()
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @GET('/users')
  Future<List<UserDto>> getUsers();
}

// Data: DataSource Implementation
class RemoteUserDataSource implements UserDataSource {
  final UserService _service;

  const RemoteUserDataSource(this._service);

  @override
  Future<List<User>> getUsers() async {
    final dtos = await _service.getUsers();
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}
```

---

## Data Flow

### User Action → State Update

```
User Tap Button
       ↓
Widget calls bloc.add(Event)
       ↓
BLoC receives Event
       ↓
BLoC calls Repository
       ↓
Repository calls Abstract DataSource
       ↓
DataSource Implementation (Remote/Local)
       ↓
Service makes API call
       ↓
Response transformed to Domain Model
       ↓
Repository returns Model to BLoC
       ↓
BLoC emits new State
       ↓
Widget rebuilds with new State
       ↓
UI updates
```

### Example Flow

```dart
// 1. User taps button
ElevatedButton(
  onPressed: () => context.read<UserListBloc>().add(
    const UserListEvent.requested(),
  ),
)

// 2. BLoC receives event
Future<void> _onRequested(event, emit) async {
  emit(const UserListState.loading());

  // 3. BLoC calls Repository
  final users = await _repository.getUsers();

  // 4. Repository calls DataSource
  // 5. DataSource calls Service
  // 6. Service returns data

  // 7. BLoC emits state
  emit(UserListState.success(users));
}

// 8. Widget rebuilds
BlocBuilder<UserListBloc, UserListState>(
  builder: (context, state) => state.when(
    loading: () => CircularProgressIndicator(),
    success: (users) => UserList(users: users),
    failure: (error) => ErrorWidget(error),
  ),
)
```

---

## Testing Strategy

The architecture enables comprehensive testing at each layer:

### BLoC Integration Tests (Minimum Requirement)

Test the entire flow with real Repository and DataSource, mock only Service:

```
BLoC (Real) → Repository (Real) → DataSource (Real) → Service (Mock)
```

### Repository Unit Tests (Optional)

Test Repository logic if complex coordination exists.

### DataSource Unit Tests (Optional)

Test DataSource implementation for data transformation logic.

### Service Unit Tests (Recommended)

Test API client with mocked HTTP responses.

See [Testing Guide](./testing.md) for detailed testing strategies.

---

## Related Documentation

- [Project Structure](./structure.md) - File organization and folder structure
- [Naming Conventions](./naming.md) - Naming standards for classes and files
- [Code Formatting](./code_formatting) - Code style guidelines
- [Testing Guide](./testing.md) - Comprehensive testing strategies

---

**Last Updated**: January 17, 2025
