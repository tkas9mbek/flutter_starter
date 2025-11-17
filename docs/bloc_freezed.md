# BLoC + Freezed Guide

> **AI Context**: This document describes the standardized process for creating BLoCs using `flutter_bloc` and `freezed`. Follow these patterns for consistency.

## Quick Reference

**AI Instruction**: When creating a BLoC:
1. Use Freezed for immutable states and events
2. Keep all definitions in ONE file (`feature_bloc.dart`)
3. Use standard state names: `initial`, `loading`, `success`, `failure`
4. Use past-tense event names: `requested`, `submitted`, `refreshed`

---

## BLoC File Structure

**AI Instruction**: All BLoC code goes in ONE file with parts:

```dart
// feature_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_bloc.freezed.dart';  // Generated file

// 1. Events (union type)
@freezed
class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.requested() = _RequestedFeatureEvent;
  const factory FeatureEvent.submitted(Data data) = _SubmittedFeatureEvent;
  const factory FeatureEvent.refreshed() = _RefreshedFeatureEvent;
}

// 2. States (union type)
@freezed
class FeatureState with _$FeatureState {
  const FeatureState._();  // Enable extensions

  const factory FeatureState.initial() = _InitialFeatureState;
  const factory FeatureState.loading() = _LoadingFeatureState;
  const factory FeatureState.success(List<Item> items) = _SuccessFeatureState;
  const factory FeatureState.failure(AppException exception) = _FailureFeatureState;

  // Helper getters
  bool get isLoading => this is _LoadingFeatureState;
}

// 3. BLoC
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;

  FeatureBloc(this._repository) : super(const FeatureState.initial()) {
    on<FeatureEvent>((event, emit) => event.when(
      requested: () => _onRequested(emit),
      submitted: (data) => _onSubmitted(data, emit),
      refreshed: () => _onRefreshed(emit),
    ));
  }

  Future<void> _onRequested(Emitter<FeatureState> emit) async {
    emit(const FeatureState.loading());
    try {
      final items = await _repository.getItems();
      emit(FeatureState.success(items));
    } on AppException catch (e) {
      emit(FeatureState.failure(e));
    }
  }

  Future<void> _onSubmitted(Data data, Emitter<FeatureState> emit) async {
    // Handle submission
  }

  Future<void> _onRefreshed(Emitter<FeatureState> emit) async {
    // Handle refresh
  }
}
```

---

## Standard State Patterns

**AI Instruction**: Use these standard state patterns:

### 1. List Loading Pattern

```dart
@freezed
class ItemListState with _$ItemListState {
  const ItemListState._();

  const factory ItemListState.initial() = _InitialItemListState;
  const factory ItemListState.loading() = _LoadingItemListState;
  const factory ItemListState.success(List<Item> items) = _SuccessItemListState;
  const factory ItemListState.failure(AppException exception) = _FailureItemListState;

  // Helper getters
  bool get isLoading => this is _LoadingItemListState;
  bool get hasData => this is _SuccessItemListState;
}
```

### 2. Details Loading Pattern

```dart
@freezed
class ItemDetailsState with _$ItemDetailsState {
  const ItemDetailsState._();

  const factory ItemDetailsState.initial() = _InitialItemDetailsState;
  const factory ItemDetailsState.loading() = _LoadingItemDetailsState;
  const factory ItemDetailsState.success(Item item) = _SuccessItemDetailsState;
  const factory ItemDetailsState.failure(AppException exception) = _FailureItemDetailsState;
}
```

### 3. Operation Pattern (Create/Update/Delete)

```dart
@freezed
class ItemOperationState with _$ItemOperationState {
  const ItemOperationState._();

  const factory ItemOperationState.initial() = _InitialItemOperationState;
  const factory ItemOperationState.submitting() = _SubmittingItemOperationState;
  const factory ItemOperationState.success() = _SuccessItemOperationState;
  const factory ItemOperationState.failure(AppException exception) = _FailureItemOperationState;

  bool get isSubmitting => this is _SubmittingItemOperationState;
}
```

---

## Standard Event Patterns

**AI Instruction**: Use past-tense event names:

### 1. Data Fetching Events

```dart
@freezed
class ItemEvent with _$ItemEvent {
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
class ItemOperationEvent with _$ItemOperationEvent {
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
class ItemEvent with _$ItemEvent {
  const factory ItemEvent.itemSelected(String id) = _ItemSelectedItemEvent;
  const factory ItemEvent.itemDeselected() = _ItemDeselectedItemEvent;
  const factory ItemEvent.itemToggled(String id) = _ItemToggledItemEvent;
}
```

---

## BLoC Event Handlers

**AI Instruction**: Separate handlers for each event:

```dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;

  FeatureBloc(this._repository) : super(const FeatureState.initial()) {
    // Map each event to handler
    on<FeatureEvent>((event, emit) => event.when(
      requested: () => _onRequested(emit),
      submitted: (data) => _onSubmitted(data, emit),
      deleted: (id) => _onDeleted(id, emit),
    ));
  }

  // Separate handler methods
  Future<void> _onRequested(Emitter<FeatureState> emit) async {
    emit(const FeatureState.loading());
    try {
      final data = await _repository.getData();
      emit(FeatureState.success(data));
    } on AppException catch (e) {
      emit(FeatureState.failure(e));
    }
  }

  Future<void> _onSubmitted(Data data, Emitter<FeatureState> emit) async {
    emit(const FeatureState.submitting());
    try {
      await _repository.save(data);
      emit(const FeatureState.success());
    } on AppException catch (e) {
      emit(FeatureState.failure(e));
    }
  }

  Future<void> _onDeleted(String id, Emitter<FeatureState> emit) async {
    try {
      await _repository.delete(id);
      emit(const FeatureState.success());
    } on AppException catch (e) {
      emit(FeatureState.failure(e));
    }
  }
}
```

---

## UI Integration

### 1. BlocBuilder (Display Data)

**AI Instruction**: Use `BlocBuilder` to display state-dependent UI:

```dart
BlocBuilder<ItemListBloc, ItemListState>(
  builder: (context, state) => state.when(
    initial: () => const SizedBox.shrink(),
    loading: () => const Center(child: CircularProgressIndicator()),
    success: (items) => ItemListView(items: items),
    failure: (exception) => ErrorWidget(exception: exception),
  ),
)
```

### 2. BlocListener (Side Effects)

**AI Instruction**: Use `BlocListener` for navigation, snackbars, dialogs:

```dart
BlocListener<ItemOperationBloc, ItemOperationState>(
  listener: (context, state) {
    state.whenOrNull(
      success: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item saved successfully')),
        );
        context.router.pop();
      },
      failure: (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(exception.toString())),
        );
      },
    );
  },
  child: YourForm(),
)
```

### 3. BlocConsumer (Both Display and Side Effects)

```dart
BlocConsumer<ItemBloc, ItemState>(
  listener: (context, state) {
    // Handle side effects
    state.whenOrNull(
      failure: (exception) => showErrorDialog(context, exception),
    );
  },
  builder: (context, state) {
    // Build UI
    return state.when(
      loading: () => LoadingWidget(),
      success: (item) => ItemWidget(item: item),
      failure: (_) => ErrorPlaceholder(),
    );
  },
)
```

---

## State Helper Methods

**AI Instruction**: Add helper getters to State for common checks:

```dart
@freezed
class ItemListState with _$ItemListState {
  const ItemListState._();  // Enable custom methods

  const factory ItemListState.initial() = _InitialItemListState;
  const factory ItemListState.loading() = _LoadingItemListState;
  const factory ItemListState.success(List<Item> items) = _SuccessItemListState;
  const factory ItemListState.failure(AppException exception) = _FailureItemListState;

  // Helper getters
  bool get isLoading => this is _LoadingItemListState;
  bool get hasData => this is _SuccessItemListState;
  bool get hasError => this is _FailureItemListState;

  List<Item> get items => maybeWhen(
    success: (items) => items,
    orElse: () => [],
  );

  String? get errorMessage => whenOrNull(
    failure: (exception) => exception.toString(),
  );
}
```

---

## Code Generation

Run after creating/modifying BLoC:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

**Generated methods:**
- `when`, `whenOrNull`, `maybeWhen` - Pattern matching
- `map`, `mapOrNull`, `maybeMap` - Type-safe mapping
- `copyWith` - Create modified copies

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
class UserListEvent with _$UserListEvent {
  const factory UserListEvent.requested() = _RequestedUserListEvent;
  const factory UserListEvent.refreshed() = _RefreshedUserListEvent;
}

@freezed
class UserListState with _$UserListState {
  const UserListState._();

  const factory UserListState.initial() = _InitialUserListState;
  const factory UserListState.loading() = _LoadingUserListState;
  const factory UserListState.success(List<User> users) = _SuccessUserListState;
  const factory UserListState.failure(AppException exception) = _FailureUserListState;

  bool get isLoading => this is _LoadingUserListState;
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _repository;

  UserListBloc(this._repository) : super(const UserListState.initial()) {
    on<UserListEvent>((event, emit) => event.when(
      requested: () => _onRequested(emit),
      refreshed: () => _onRefreshed(emit),
    ));
  }

  Future<void> _onRequested(Emitter<UserListState> emit) async {
    emit(const UserListState.loading());
    try {
      final users = await _repository.getUsers();
      emit(UserListState.success(users));
    } on AppException catch (e) {
      emit(UserListState.failure(e));
    }
  }

  Future<void> _onRefreshed(Emitter<UserListState> emit) async {
    try {
      final users = await _repository.getUsers();
      emit(UserListState.success(users));
    } on AppException catch (e) {
      emit(UserListState.failure(e));
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
      "class ${1:Feature}Event with _$${1:Feature}Event {",
      "  const factory ${1:Feature}Event.requested() = _Requested${1:Feature}Event;",
      "}",
      "",
      "@freezed",
      "class ${1:Feature}State with _$${1:Feature}State {",
      "  const ${1:Feature}State._();",
      "",
      "  const factory ${1:Feature}State.initial() = _Initial${1:Feature}State;",
      "  const factory ${1:Feature}State.loading() = _Loading${1:Feature}State;",
      "  const factory ${1:Feature}State.success() = _Success${1:Feature}State;",
      "  const factory ${1:Feature}State.failure(AppException exception) = _Failure${1:Feature}State;",
      "",
      "  bool get isLoading => this is _Loading${1:Feature}State;",
      "}",
      "",
      "class ${1:Feature}Bloc extends Bloc<${1:Feature}Event, ${1:Feature}State> {",
      "  final ${1:Feature}Repository _repository;",
      "",
      "  ${1:Feature}Bloc(this._repository) : super(const ${1:Feature}State.initial()) {",
      "    on<${1:Feature}Event>((event, emit) => event.when(",
      "      requested: () => _onRequested(emit),",
      "    ));",
      "  }",
      "",
      "  Future<void> _onRequested(Emitter<${1:Feature}State> emit) async {",
      "    emit(const ${1:Feature}State.loading());",
      "    try {",
      "      final data = await _repository.getData();",
      "      emit(${1:Feature}State.success());",
      "    } on AppException catch (e) {",
      "      emit(${1:Feature}State.failure(e));",
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

---

**Last Updated**: January 18, 2025
