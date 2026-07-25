# BLoC + Freezed Guide

## Quick Reference

When creating a BLoC:
1. Use Freezed `sealed` unions for immutable states and events
2. Keep all definitions in ONE file (`feature_bloc.dart`)
3. Use standard state names: `initial`, `loading`, `success`, `failure`
4. Use past-tense event names: `requested`, `submitted`, `refreshed`
5. State case classes are public (`SuccessFeatureState`) so UI can pattern-match; event case classes stay private (`_RequestedFeatureEvent`)

---

## BLoC File Structure

All BLoC code goes in ONE file with parts:

```dart
// feature_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_bloc.freezed.dart';  // Generated file

// 1. Events (union type — case classes stay private)
@freezed
sealed class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.requested() = _RequestedFeatureEvent;
  const factory FeatureEvent.submitted(Data data) = _SubmittedFeatureEvent;
  const factory FeatureEvent.refreshed() = _RefreshedFeatureEvent;
}

// 2. States (union type — case classes are public so UI can pattern-match)
@freezed
sealed class FeatureState with _$FeatureState {
  const FeatureState._();  // Enable extensions

  const factory FeatureState.initial() = InitialFeatureState;
  const factory FeatureState.loading() = LoadingFeatureState;
  const factory FeatureState.success(List<Item> items) = SuccessFeatureState;
  const factory FeatureState.failure(AppException exception) = FailureFeatureState;

  // Helper getters
  bool get isLoading => this is LoadingFeatureState;
}

// 3. BLoC
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;

  FeatureBloc(this._repository) : super(const FeatureState.initial()) {
    on<_RequestedFeatureEvent>(_onRequested);
    on<_SubmittedFeatureEvent>(_onSubmitted);
    on<_RefreshedFeatureEvent>(_onRefreshed);
  }

  Future<void> _onRequested(
    _RequestedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    emit(const FeatureState.loading());

    try {
      final items = await _repository.getItems();

      return emit(FeatureState.success(items));
    } on AppException catch (e) {
      return emit(FeatureState.failure(e));
    }
  }

  Future<void> _onSubmitted(
    _SubmittedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    // Handle submission (event.data carries the payload)
  }

  Future<void> _onRefreshed(
    _RefreshedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    // Handle refresh
  }
}
```

---

## Standard State Patterns

Use these standard state patterns:

### 1. List Loading Pattern

```dart
@freezed
sealed class ItemListState with _$ItemListState {
  const ItemListState._();

  const factory ItemListState.initial() = InitialItemListState;
  const factory ItemListState.loading() = LoadingItemListState;
  const factory ItemListState.success(List<Item> items) = SuccessItemListState;
  const factory ItemListState.failure(AppException exception) = FailureItemListState;

  // Helper getters
  bool get isLoading => this is LoadingItemListState;
  bool get hasData => this is SuccessItemListState;
}
```

### 2. Details Loading Pattern

```dart
@freezed
sealed class ItemDetailsState with _$ItemDetailsState {
  const ItemDetailsState._();

  const factory ItemDetailsState.initial() = InitialItemDetailsState;
  const factory ItemDetailsState.loading() = LoadingItemDetailsState;
  const factory ItemDetailsState.success(Item item) = SuccessItemDetailsState;
  const factory ItemDetailsState.failure(AppException exception) = FailureItemDetailsState;
}
```

### 3. Operation Pattern (Create/Update/Delete)

```dart
@freezed
sealed class ItemOperationState with _$ItemOperationState {
  const ItemOperationState._();

  const factory ItemOperationState.initial() = InitialItemOperationState;
  const factory ItemOperationState.submitting() = SubmittingItemOperationState;
  const factory ItemOperationState.success() = SuccessItemOperationState;
  const factory ItemOperationState.failure(AppException exception) = FailureItemOperationState;

  bool get isSubmitting => this is SubmittingItemOperationState;
}
```

### 4. Nested Status Pattern (For Persistent Data)

For states that need persistent data (like selectedDate, filters, pagination) across status changes, use a nested status pattern:

```dart
// Status union - handles loading/success/failure
@freezed
sealed class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = InitialCalendarStatus;
  const factory CalendarStatus.loading() = LoadingCalendarStatus;
  const factory CalendarStatus.success({
    required List<Task> tasks,
  }) = SuccessCalendarStatus;
  const factory CalendarStatus.failure({
    required AppException exception,
  }) = FailureCalendarStatus;
}

// State with persistent data + nested status (single constructor → abstract)
@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime selectedDate,  // Persists across status changes
    required CalendarStatus status,   // Changes with loading/success/failure
  }) = _CalendarState;

  const CalendarState._();

  // Factory for initial state
  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  // Helper methods
  bool get isLoading => status is LoadingCalendarStatus;
}

// Events
@freezed
sealed class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.dateSelected(DateTime date) = _DateSelectedCalendarEvent;
  const factory CalendarEvent.refreshed() = _RefreshedCalendarEvent;  // Reloads current date
}

// BLoC handlers
Future<void> _onDateSelected(
  _DateSelectedCalendarEvent event,
  Emitter<CalendarState> emit,
) async {
  // Update persistent data AND status
  emit(state.copyWith(
    selectedDate: event.date,
    status: const CalendarStatus.loading(),
  ));

  try {
    final tasks = await _repository.getTasksByDate(event.date);

    return emit(state.copyWith(
      status: CalendarStatus.success(tasks: tasks),
    ));
  } on AppException catch (e) {
    return emit(state.copyWith(
      status: CalendarStatus.failure(exception: e),
    ));
  }
}

Future<void> _onRefreshed(
  _RefreshedCalendarEvent event,
  Emitter<CalendarState> emit,
) async {
  // Reload using current persistent data
  emit(state.copyWith(status: const CalendarStatus.loading()));

  try {
    final tasks = await _repository.getTasksByDate(state.selectedDate);

    return emit(state.copyWith(
      status: CalendarStatus.success(tasks: tasks),
    ));
  } on AppException catch (e) {
    return emit(state.copyWith(
      status: CalendarStatus.failure(exception: e),
    ));
  }
}
```

**Usage in UI:**
```dart
BlocBuilder<CalendarBloc, CalendarState>(
  builder: (context, state) => Column(
    children: [
      // Access persistent data directly
      CalendarPicker(selectedDate: state.selectedDate),

      // Use nested status for content — exhaustive switch expression
      Expanded(
        child: switch (state.status) {
          InitialCalendarStatus() => EmptyView(),
          LoadingCalendarStatus() => LoadingIndicator(),
          SuccessCalendarStatus(:final tasks) => TasksList(tasks: tasks),
          FailureCalendarStatus(:final exception) =>
            ErrorWidget(exception: exception),
        },
      ),
    ],
  ),
)
```

**When to use nested status:**
- State needs to persist data across multiple load operations (filters, pagination, selection)
- You need to refresh/reload without changing persistent data
- You want to avoid duplicating persistent data in every status variant

**When NOT to use nested status:**
- Simple CRUD operations that don't need persistent data
- One-time data fetch scenarios
- States where all data changes together

---

## Standard Event Patterns

Use past-tense event names:

### 1. Data Fetching Events

```dart
@freezed
sealed class ItemEvent with _$ItemEvent {
  // Load initial data
  const factory ItemEvent.requested() = _RequestedItemEvent;

  // Refresh/reload data
  const factory ItemEvent.refreshed() = _RefreshedItemEvent;

  // Load more (pagination)
  const factory ItemEvent.loadMoreRequested() = _LoadMoreRequestedItemEvent;
}
```

### 2. Form/Operation Events

```dart
@freezed
sealed class ItemOperationEvent with _$ItemOperationEvent {
  // Submit form/operation
  const factory ItemOperationEvent.submitted(ItemData data) = _SubmittedItemOperationEvent;

  // Form field changed
  const factory ItemOperationEvent.fieldChanged(String field, dynamic value) = _FieldChangedItemOperationEvent;

  // Validation triggered
  const factory ItemOperationEvent.validated() = _ValidatedItemOperationEvent;
}
```

### 3. Item Selection Events

```dart
@freezed
sealed class ItemEvent with _$ItemEvent {
  const factory ItemEvent.itemSelected(String id) = _ItemSelectedItemEvent;
  const factory ItemEvent.itemDeselected() = _ItemDeselectedItemEvent;
  const factory ItemEvent.itemToggled(String id) = _ItemToggledItemEvent;
}
```

---

## BLoC Event Handlers

Register a typed `on<_Event>` per event and give each its own handler:

```dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;

  FeatureBloc(this._repository) : super(const FeatureState.initial()) {
    // Map each event to handler
    on<_RequestedFeatureEvent>(_onRequested);
    on<_SubmittedFeatureEvent>(_onSubmitted);
    on<_DeletedFeatureEvent>(_onDeleted);
  }

  // Separate handler methods
  Future<void> _onRequested(
    _RequestedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    emit(const FeatureState.loading());

    try {
      final data = await _repository.getData();

      return emit(FeatureState.success(data));
    } on AppException catch (e) {
      return emit(FeatureState.failure(e));
    }
  }

  Future<void> _onSubmitted(
    _SubmittedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    emit(const FeatureState.submitting());

    try {
      await _repository.save(event.data);

      return emit(const FeatureState.success());
    } on AppException catch (e) {
      return emit(FeatureState.failure(e));
    }
  }

  Future<void> _onDeleted(
    _DeletedFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    try {
      await _repository.delete(event.id);

      return emit(const FeatureState.success());
    } on AppException catch (e) {
      return emit(FeatureState.failure(e));
    }
  }
}
```

---

## UI Integration

### 1. BlocBuilder (Display Data)

Use `BlocBuilder` with an exhaustive `switch` over the sealed state:

```dart
BlocBuilder<ItemListBloc, ItemListState>(
  builder: (context, state) => switch (state) {
    InitialItemListState() => const SizedBox.shrink(),
    LoadingItemListState() => const Center(child: CircularProgressIndicator()),
    SuccessItemListState(:final items) => ItemListView(items: items),
    FailureItemListState(:final exception) => ErrorWidget(exception: exception),
  },
)
```

### 2. BlocListener (Side Effects)

Use `BlocListener` with `if-case` / `is` checks for navigation, snackbars, dialogs:

```dart
BlocListener<ItemOperationBloc, ItemOperationState>(
  listener: (context, state) {
    if (state is SuccessItemOperationState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item saved successfully')),
      );
      context.router.pop();
    }

    if (state case FailureItemOperationState(:final exception)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(exception.toString())),
      );
    }
  },
  child: YourForm(),
)
```

### 3. BlocConsumer (Both Display and Side Effects)

```dart
BlocConsumer<ItemBloc, ItemState>(
  listener: (context, state) {
    // Handle side effects
    if (state case FailureItemState(:final exception)) {
      showErrorDialog(context, exception);
    }
  },
  builder: (context, state) => switch (state) {
    SuccessItemState(:final item) => ItemWidget(item: item),
    FailureItemState() => ErrorPlaceholder(),
    InitialItemState() || LoadingItemState() => LoadingWidget(),
  },
)
```

---

## State Helper Methods

Add helper getters to State for common checks:

```dart
@freezed
sealed class ItemListState with _$ItemListState {
  const ItemListState._();  // Enable custom methods

  const factory ItemListState.initial() = InitialItemListState;
  const factory ItemListState.loading() = LoadingItemListState;
  const factory ItemListState.success(List<Item> items) = SuccessItemListState;
  const factory ItemListState.failure(AppException exception) = FailureItemListState;

  // Helper getters
  bool get isLoading => this is LoadingItemListState;
  bool get hasData => this is SuccessItemListState;
  bool get hasError => this is FailureItemListState;

  List<Item> get items => switch (this) {
    SuccessItemListState(:final items) => items,
    _ => [],
  };

  String? get errorMessage => switch (this) {
    FailureItemListState(:final exception) => exception.toString(),
    _ => null,
  };
}
```

---

## Code Generation

Run after creating/modifying BLoC:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

**Generated methods:**
- `copyWith` - Create modified copies
- `==` / `hashCode` - Value equality for correct `BlocBuilder` rebuilds

**Pattern matching:** Freezed 3 no longer generates `when` / `map` helpers. Use Dart's built-in `switch` expressions and `if-case` on the sealed state classes instead.

---

## Complete Example

```dart
// user_list_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/user/domain/user_repository.dart';
import 'package:starter/features/user/model/user.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'user_list_bloc.freezed.dart';

@freezed
sealed class UserListEvent with _$UserListEvent {
  const factory UserListEvent.requested() = _RequestedUserListEvent;
  const factory UserListEvent.refreshed() = _RefreshedUserListEvent;
}

@freezed
sealed class UserListState with _$UserListState {
  const UserListState._();

  const factory UserListState.initial() = InitialUserListState;
  const factory UserListState.loading() = LoadingUserListState;
  const factory UserListState.success(List<User> users) = SuccessUserListState;
  const factory UserListState.failure(AppException exception) = FailureUserListState;

  bool get isLoading => this is LoadingUserListState;
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _repository;

  UserListBloc(this._repository) : super(const UserListState.initial()) {
    on<_RequestedUserListEvent>(_onRequested);
    on<_RefreshedUserListEvent>(_onRefreshed);
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

  Future<void> _onRefreshed(
    _RefreshedUserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    try {
      final users = await _repository.getUsers();

      return emit(UserListState.success(users));
    } on AppException catch (e) {
      return emit(UserListState.failure(e));
    }
  }
}
```

---

## VS Code Snippet

Add to your VS Code snippets for quick BLoC generation:

```json
{
  "Freezed Bloc": {
    "prefix": "genbloc",
    "body": [
      "import 'package:flutter_bloc/flutter_bloc.dart';",
      "import 'package:freezed_annotation/freezed_annotation.dart';",
      "",
      "part '${TM_FILENAME_BASE}.freezed.dart';",
      "",
      "@freezed",
      "sealed class ${1:Feature}Event with _$${1:Feature}Event {",
      "  const factory ${1:Feature}Event.requested() = _Requested${1:Feature}Event;",
      "}",
      "",
      "@freezed",
      "sealed class ${1:Feature}State with _$${1:Feature}State {",
      "  const ${1:Feature}State._();",
      "",
      "  const factory ${1:Feature}State.initial() = Initial${1:Feature}State;",
      "  const factory ${1:Feature}State.loading() = Loading${1:Feature}State;",
      "  const factory ${1:Feature}State.success() = Success${1:Feature}State;",
      "  const factory ${1:Feature}State.failure(AppException exception) = Failure${1:Feature}State;",
      "",
      "  bool get isLoading => this is Loading${1:Feature}State;",
      "}",
      "",
      "class ${1:Feature}Bloc extends Bloc<${1:Feature}Event, ${1:Feature}State> {",
      "  final ${1:Feature}Repository _repository;",
      "",
      "  ${1:Feature}Bloc(this._repository) : super(const ${1:Feature}State.initial()) {",
      "    on<_Requested${1:Feature}Event>(_onRequested);",
      "  }",
      "",
      "  Future<void> _onRequested(",
      "    _Requested${1:Feature}Event event,",
      "    Emitter<${1:Feature}State> emit,",
      "  ) async {",
      "    emit(const ${1:Feature}State.loading());",
      "",
      "    try {",
      "      final data = await _repository.getData();",
      "",
      "      return emit(${1:Feature}State.success());",
      "    } on AppException catch (e) {",
      "      return emit(${1:Feature}State.failure(e));",
      "    }",
      "  }",
      "}"
    ],
    "description": "Generates freezed BLoC with standard pattern"
  }
}
```

---

## Resources

- [Flutter BLoC Documentation](https://bloclibrary.dev)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Flutter Freezed BLoC Without Boilerplate](https://medium.com/@morning-stars/flutter-freezed-bloc-7-2-0-without-boilerplate-99fe6051f8d)
