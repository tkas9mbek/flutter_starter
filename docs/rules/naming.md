# Naming Conventions

## Core Principle

**Feature + Description + Type** — a name tells you the feature it belongs to, what it does, and what kind of component it is.

---

## General Rules

### Functions & Methods

Start with a verb: `fetchUsers()`, `calculateTotal()`, `saveData()` — never `users()`, `total()`, `data()`.

### Classes

`Feature + Description + Type`

- **Feature**: domain/module name (`Tax`, `User`, `Note`)
- **Description**: specific use case or data — omit only when the feature has a single instance of that Type (one screen, one repository); required as soon as a second instance exists.
- **Type**: component type (`Repository`, `Bloc`, `Screen`, `Widget`)

```dart
// ✓ Correct
class TaxRepository { ... }     // single implementation, description omitted
class TaxPaymentScreen { ... }  // Payment is the description
class UserListBloc { ... }      // List is the description
class LoginScreen { ... }       // only one screen in the feature

// ✗ Wrong
class TaxData { ... }           // too generic
class NoteScreen { ... }        // Note has NoteListScreen and NoteDetailScreen — ambiguous
```

Private (`_`) classes follow the same rule — never a bare `_Item`; see [code_preferences § Private classes](./code_preferences.md#private-classes-use-a-full-descriptive-name). The feature word leads widget names ([§ Feature word leads](./code_preferences.md#feature-word-leads-the-widget-name)).

---

## File Names

`snake_case`, matching the main class name: `TaxPaymentScreen` → `tax_payment_screen.dart`, `ApiAuthAuthorizedDataSource` → `api_auth_authorized_data_source.dart`.

---

## Repository & DataSource Naming

### Repository

One per feature, description omitted (`UserRepository`, `TaskRepository`). Repositories are concrete — see [code_standards § Repository](./code_standards.md#repository-depends-on-abstract-datasource).

### DataSource

The abstract type lives in `domain/` with the base pattern — no `I` / `Abstract` prefix. **Implementations are prefixed with their source**, source first (`UserLocalDataSource` is wrong):

| Kind | Pattern | Example |
|---|---|---|
| Abstract | `FeatureDataSource` | `UserDataSource`, `AuthAuthorizedDataSource` |
| REST (`ApiClient`) | `ApiFeatureDataSource` | `ApiUserDataSource` |
| Local / secure storage | `LocalFeatureDataSource` / `SecureFeatureDataSource` | `LocalSettingsDataSource`, `SecureAuthLocalDataSource` |
| Mock twin | `MockFeatureDataSource` | `MockUserDataSource` |

- REST implementations are `Api*` (not `Remote*`) and live in `data/`; mock twins are `Mock*` and live in `data/mock/` beside their `Mock<Feature>Scenarios` — see [mocking](../guides/mocking.md).
- A feature with several abstract sources keeps the qualifier on every implementation (`ApiAuthAuthorizedDataSource`, `MockAuthAuthorizedDataSource`).
- Multiple implementations of a repository are rare; if they exist, prefix the same way (`StripePaymentRepository implements PaymentRepository`).

### API access

There is no separate "service" layer: all HTTP goes through the typed `ApiClient` (from `starter_toolkit`), called only by `Api*DataSource` classes. A `FeatureService` / Retrofit-style class bypasses the DataSource contract and adds a layer the architecture doesn't have.

```dart
class ApiTaskDataSource implements TaskDataSource {
  const ApiTaskDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<Task>> getTasks() => _client.requestJsonList<Task>(
        method: HttpMethod.get,
        path: '/tasks',
        fromJson: Task.fromJson,
      );
}
```

---

## Widget Naming

Describe what the widget displays or does, not its Flutter base type: `UserProfileCard`, `TaskListView`, `PriceRow`, `SubmitButton`. Never use `Container`, `Widget` or `Component` in a name (`UserContainer`, `TaskWidget`, `InfoComponent`); pick a concrete UI type (Card / Panel / Tile).

---

## BLoC Naming

Follow the official [BLoC naming conventions](https://bloclibrary.dev/naming-conventions/).

| Purpose | Pattern | Example |
|---|---|---|
| List fetching | `FeatureListBloc` | `UserListBloc` |
| Create / edit | `FeatureOperationBloc` | `TaskOperationBloc` |
| Details view | `FeatureDetailsBloc` | `UserDetailsBloc` |

BLoCs are named with nouns, not verbs (`UserCreationBloc`, not `AddUserBloc`).

**Events** — **past tense**; case classes **private**, named `_{Verb}{Feature}Event`. ✓ `requested`, `submitted`, `deleted`, `refreshed` · ✗ `request`, `submit`, `delete`, `refresh`.

**States** — the canonical set `initial`, `loading`, `success`, `failure` (plus `submitting` for operation blocs) — not `initializing` / `loaded` / `succeeded` / `failed`. Case classes are **public**, `{Status}{Feature}State`, so UI code can pattern-match (Freezed 3 has no `when` / `map`).

```dart
@freezed
sealed class UserListEvent with _$UserListEvent {
  const factory UserListEvent.requested() = _RequestedUserListEvent;
  const factory UserListEvent.itemSelected(String id) = _ItemSelectedUserListEvent;
}

@freezed
sealed class UserListState with _$UserListState {
  const factory UserListState.initial() = InitialUserListState;
  const factory UserListState.loading() = LoadingUserListState;
  const factory UserListState.success(List<User> users) = SuccessUserListState;
  const factory UserListState.failure(AppException exception) = FailureUserListState;
}
```

---

## Model Naming

Domain-specific names, no generic suffixes: `User`, `Task`, `OrderItem`, `PaymentDetails` — not `UserModel`, `TaskData`, `OrderItemDto` (we don't use DTOs).

- **Presentation-layer variants use `*UiModel`** (`ExceptionUiModel`, `TaskStatusUiModel`): the `Model` ban targets *domain* types, and `avoid_naming_antipatterns` explicitly exempts `UiModel`. Forms are `*Form`, domain models stay bare. `TaskStatusModel` / `TaskStatusHelper` / `TaskStatusMapper` are all wrong names for a UI model — see [polymorphism guide § UI Model Pattern](../guides/polymorphism.md#ui-model-pattern).
- **Transport-only types** take `Request` / `Response` (`LoginRequest`, `TaskCreateRequest`, `AuthRegisterRequestBody`). Responses normally reuse the domain model directly.

---

## Anti-Patterns: Bad → Good

Enforced by the `avoid_naming_antipatterns` lint where noted: `Impl` suffix, `Module` in a Repository/DataSource/Bloc/Service name, `Model` suffix under `model/` (not `UiModel`). The rest is review-time.

| ❌ Bad | ✅ Correct | Why |
|--------|-----------|-----|
| `Property` | `RealEstateProperty` | Too generic — missing feature context |
| `UserModel` | `User` | `Model` suffix is redundant for domain types |
| `TaskDataSourceImpl` | `ApiTaskDataSource` | `Impl` says nothing — name the source |
| `RemoteTaskDataSource` | `ApiTaskDataSource` | REST sources are `Api*` |
| `TitleValueTile` | `TaxPropertyTitleValueTile` | Missing feature prefix — collides across modules |
| `ImageContainer` | `UserAvatarCard` | `Container` is a Flutter widget; pick a specific UI type |
| `AddUserBloc` | `UserCreationBloc` | BLoCs are nouns, not verbs |
| `UserFetchEvent` / `.fetch()` | `.requested()` → `_RequestedUserEvent` | Events past tense, case classes private |
| `UserLocalDataSource` | `LocalUserDataSource` | Source prefix (Api / Local / Mock) comes first |
| `AddUserWidget` | `UserCreationButton` | `Widget` is vague; use a concrete UI type |
| `MainScreen` | `HomeDashboardScreen` | Avoid `Main` / `Default` — say what the screen is |

`Module` is only legitimate on DI config classes (`configs/{feature}_module.dart extends AppModule`).

---

## Quick Reference

| Component | Pattern | Example |
|-----------|---------|---------|
| Repository | `FeatureRepository` | `UserRepository` |
| Abstract / API / Local / Mock DS | `FeatureDataSource` / `Api…` / `Local…` / `Mock…` | `UserDataSource` / `ApiUserDataSource` / `LocalUserDataSource` / `MockUserDataSource` |
| BLoC | `FeatureDescriptionBloc` | `UserListBloc` |
| Screen | `FeatureDescriptionScreen` | `LoginScreen` |
| Widget | `FeatureDescriptiveType` | `UserProfileCard` |
| Domain model | `DomainName` | `User`, `Task` |
| UI model | `FeatureThingUiModel` | `TaskStatusUiModel` |
| Request | `FeatureActionRequest` | `LoginRequest` |
| State case class (public) | `{Status}{Feature}State` | `SuccessUserListState` |
| Event case class (private) | `_{Verb}{Feature}Event` | `_RequestedUserListEvent` |

---

## Related Documentation

- [Architecture](../guides/architecture.md) · [Structure](../guides/structure.md) · [BLoC & Freezed](../guides/freezed_bloc.md)
