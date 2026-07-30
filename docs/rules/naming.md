# Naming Conventions

## Core Principle

Follow the pattern: **Feature + Description + Type**

By reading a name, developers should understand:
- What feature it belongs to
- What it does (description)
- What type of component it is

---

## General Rules

### Functions & Methods

Start with a verb indicating the action

```dart
// ✓ Correct
void fetchUsers() { ... }
void calculateTotal() { ... }
Future<void> saveData() { ... }

// ✗ Wrong
void users() { ... }
void total() { ... }
void data() { ... }
```

### Classes

**Pattern**: `Feature + Description + Type`

- **Feature**: Domain/module name (e.g., `Tax`, `User`, `Note`)
- **Description**: Specific use case or data — omit only when the feature has a single instance of
  that Type (e.g. one screen, one repository); required as soon as a second instance exists.
- **Type**: Component type (`Repository`, `Bloc`, `Screen`, `Widget`)

```dart
// ✓ Correct
class TaxRepository { ... }           // Single implementation, omit description
class TaxPaymentScreen { ... }        // Payment is the description
class UserListBloc { ... }            // List is the description
class LoginScreen { ... }             // Feature has only one screen, omit description

// ✗ Wrong
class TaxData { ... }                 // Too generic
class TaxModel { ... }                // Avoid "Model"
class NoteScreen { ... }              // Note has both NoteListScreen and NoteDetailScreen —
                                       // ambiguous without a description
```

---

## File Names

Use `snake_case`. Match the main class name

```dart
// Class: TaxPaymentScreen
// File: tax_payment_screen.dart

// Class: UserListBloc
// File: user_list_bloc.dart

// Class: ApiAuthDataSource
// File: api_auth_data_source.dart
```

---

## Abstraction Naming

### Abstract Classes

Use the base pattern without implementation prefix

```dart
// ✓ Correct - Abstract
abstract class UserDataSource { ... }
abstract class TaskRepository { ... }  // Only if truly needed

// ✗ Wrong
abstract class IUserDataSource { ... }  // No "I" prefix
abstract class AbstractUserDataSource { ... }  // No "Abstract" prefix
```

### Concrete Implementations

Prefix with implementation type

```dart
// ✓ Correct - Implementations
class ApiUserDataSource implements UserDataSource { ... }
class LocalUserDataSource implements UserDataSource { ... }
class MockUserDataSource implements UserDataSource { ... }

class ApiAuthDataSource implements AuthDataSource { ... }
class SecureAuthLocalDataSource implements AuthLocalDataSource { ... }
```

---

## Widget Naming

Use descriptive names based on purpose, not just widget type

### Generic Widgets

Describe what the widget displays or does:

```dart
// ✓ Correct
class UserProfileCard extends StatelessWidget { ... }
class TaskListView extends StatelessWidget { ... }
class PriceRow extends StatelessWidget { ... }
class SubmitButton extends StatelessWidget { ... }

// ✗ Wrong
class UserContainer extends StatelessWidget { ... }  // Too generic
class TaskWidget extends StatelessWidget { ... }     // Too generic
```

### Avoid Generic Names

Never use `Container`, `Widget`, `Component` in names

```dart
// ✓ Correct
class ProductDetailsCard { ... }
class UserInfoTile { ... }

// ✗ Wrong
class ProductContainer { ... }
class UserWidget { ... }
class InfoComponent { ... }
```

---

## BLoC Naming

Follow official [BLoC naming conventions](https://bloclibrary.dev/naming-conventions/)

### BLoC Classes

Pattern: `Feature + Description + Bloc`

```dart
class UserListBloc extends Bloc<UserListEvent, UserListState> { ... }
class TaskOperationBloc extends Bloc<TaskOperationEvent, TaskOperationState> { ... }
class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> { ... }
```

### Events

Use **past tense** (events represent actions that already occurred)

```dart
@freezed
class UserListEvent with _$UserListEvent {
  const factory UserListEvent.requested() = _RequestedUserListEvent;
  const factory UserListEvent.refreshed() = _RefreshedUserListEvent;
  const factory UserListEvent.itemSelected(String id) = _ItemSelectedUserListEvent;
}

// ✓ Correct: requested, submitted, deleted, refreshed, updated
// ✗ Wrong: request, submit, delete, refresh, update
```

### States

Use **nouns** (states represent snapshots)

```dart
@freezed
class UserListState with _$UserListState {
  const factory UserListState.initial() = _InitialUserListState;
  const factory UserListState.loading() = _LoadingUserListState;
  const factory UserListState.success(List<User> users) = _SuccessUserListState;
  const factory UserListState.failure(AppException exception) = _FailureUserListState;
}

// ✓ Correct: initial, loading, success, failure
// ✗ Wrong: initializing, loaded, succeeded, failed
```

### Common BLoC Names

Use these standard patterns:

| Purpose | Pattern | Example |
|---------|---------|---------|
| List fetching | `FeatureListBloc` | `NotesListBloc`, `UsersListBloc` |
| Create/Edit | `FeatureOperationBloc` | `NoteOperationBloc`, `TaskOperationBloc` |
| Details view | `FeatureDetailsBloc` | `UserDetailsBloc`, `OrderDetailsBloc` |

---

## Model Naming

Use domain-specific names, avoid generic suffixes

```dart
// ✓ Correct
class User { ... }
class Task { ... }
class OrderItem { ... }
class PaymentDetails { ... }

// ✗ Wrong
class UserModel { ... }         // Avoid "Model"
class TaskData { ... }          // Avoid "Data"
class OrderItemDto { ... }      // We don't use DTOs
```

### Request/Response Models

```dart
// ✓ Correct
class LoginRequest { ... }
class TaskCreateRequest { ... }
class AuthRegisterRequestBody { ... }

// For responses, use domain model directly
class User { ... }  // Used for both request and response
class Task { ... }
```

---

## Repository & DataSource Naming

### Repository

Usually one per feature, omit description

```dart
// ✓ Correct - Single implementation
class UserRepository { ... }
class TaskRepository { ... }
class AuthRepository { ... }

// ✓ Correct - Multiple implementations (rare)
abstract class PaymentRepository { ... }
class StripePaymentRepository implements PaymentRepository { ... }
class PayPalPaymentRepository implements PaymentRepository { ... }
```

### DataSource

Always abstract, prefix implementations

```dart
// Abstract
abstract class UserDataSource { ... }
abstract class AuthAuthorizedDataSource { ... }

// Implementations
class ApiUserDataSource implements UserDataSource { ... }
class LocalUserDataSource implements UserDataSource { ... }
class MockUserDataSource implements UserDataSource { ... }

class ApiAuthAuthorizedDataSource implements AuthAuthorizedDataSource { ... }
class MockAuthAuthorizedDataSource implements AuthAuthorizedDataSource { ... }
```

---

## Service Naming

API services use `Feature + Service`

```dart
// ✓ Correct - Retrofit services
@RestApi()
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @GET('/users')
  Future<List<User>> getUsers();
}

@RestApi()
abstract class TaskService {
  factory TaskService(Dio dio) = _TaskService;

  @GET('/tasks')
  Future<List<Task>> getTasks();
}
```

---

## Examples

### Example 1: Tax Feature Repository

**Class**: `TaxRepository`
- **Feature**: Tax
- **Description**: (omitted - single implementation)
- **Type**: Repository

Single repository for tax feature, no description needed.

### Example 2: Tax Payment Screen

**Class**: `TaxPaymentScreen`
- **Feature**: Tax
- **Description**: Payment
- **Type**: Screen

Screen for handling tax payments.

### Example 3: Tax Debts List BLoC

**Class**: `TaxDebtsListBloc`
- **Feature**: Tax
- **Description**: DebtsList
- **Type**: Bloc

BLoC managing the list of tax debts.

### Example 4: User Data Source

**Abstract**: `UserDataSource`
**Implementations**:
- `ApiUserDataSource` - API implementation
- `LocalUserDataSource` - Database implementation
- `MockUserDataSource` - Testing implementation

### Example 5: Authentication

**BLoC**: `LoginBloc`
- **Feature**: Login
- **Type**: Bloc

**Events**:
```dart
const factory LoginEvent.submitted(String phone, String password) = _SubmittedLoginEvent;
const factory LoginEvent.passwordVisibilityToggled() = _PasswordVisibilityToggledLoginEvent;
```

**States**:
```dart
const factory LoginState.initial() = _InitialLoginState;
const factory LoginState.loading() = _LoadingLoginState;
const factory LoginState.success() = _SuccessLoginState;
const factory LoginState.failure(AppException exception) = _FailureLoginState;
```

---

## Anti-Patterns: Bad → Good

Concrete corrections for the most common naming mistakes seen in review.

| ❌ Bad | ✅ Correct | Why |
|--------|-----------|-----|
| `Property` | `RealEstateProperty` | Too generic — missing feature context |
| `UserModel` | `User` | `Model` suffix is redundant for domain types |
| `TitleValueTile` | `TaxPropertyTitleValueTile` | Missing feature prefix — collides across modules |
| `ImageContainer` | `UserAvatarCard` | `Container` is a Flutter widget; pick a specific UI type (Card / Panel / Tile) |
| `AddUserBloc` | `UserCreationBloc` | BLoCs are named with nouns, not verbs |
| `UserFetchEvent` | `UserRequestedEvent` | Events must be past tense |
| `UserLocalDataSource` | `LocalUserDataSource` | Source prefix (Api / Local / Mock) comes first |
| `AddUserWidget` | `UserCreationButton` | `Widget` is vague; use a concrete UI type |
| `MainScreen` | `HomeDashboardScreen` | Avoid `Main` / `Default` — say what the screen actually is |

---

## Quick Reference

| Component | Pattern | Example |
|-----------|---------|---------|
| Repository | `FeatureRepository` | `UserRepository` |
| Abstract DS | `FeatureDataSource` | `UserDataSource` |
| API DS | `ApiFeatureDataSource` | `ApiUserDataSource` |
| Local DS | `LocalFeatureDataSource` | `LocalUserDataSource` |
| Mock DS | `MockFeatureDataSource` | `MockUserDataSource` |
| BLoC | `FeatureDescriptionBloc` | `UserListBloc` |
| Screen | `FeatureDescriptionScreen` | `LoginScreen` |
| Widget | `DescriptiveWidget` | `UserProfileCard` |
| Service | `FeatureService` | `UserService` |
| Model | `DomainName` | `User`, `Task` |
| Request | `FeatureActionRequest` | `LoginRequest` |

---

## Related Documentation

- [Architecture](../guides/architecture.md) - Layer structure
- [Structure](../guides/structure.md) - File organization
- [BLoC & Freezed](../guides/freezed_bloc.md) - BLoC patterns
