# BLoC + Freezed Guide

File layout, state shapes, handler rules and UI integration — the single source for BLoC rules. Rule summary: [`code_standards.md` § BLoC](./code_standards.md#bloc); naming: [`naming.md` § BLoC Naming](./naming.md#bloc-naming); review rules: `BLOC-*` in [`code_review.md`](../guides/code_review.md).

## Quick Reference

1. Freezed `sealed` unions for immutable states and events.
2. Standard state names `initial` / `loading` / `success` / `failure` (`submitting` for operations); past-tense event names `requested` / `submitted` / `refreshed`.
3. State case classes are public (`SuccessFeatureState`) so UI can pattern-match; event case classes stay private (`_RequestedFeatureEvent`).
4. Larger BLoCs split into two files joined via `part` / `part of` (below); a small BLoC may keep events and states in the bloc file (`tasks_list_bloc.dart`).
5. Freezed 3 generates no `when` / `map` — use `switch` / `if-case` / `is` on the sealed classes.

---

## Why Freezed

| Need | Freezed gives you |
|---|---|
| Sealed unions for events / states | `@freezed sealed class` + factory constructors |
| `==` / `hashCode` so `BlocBuilder` rebuilds correctly | Auto-generated |
| `copyWith` for compound states | Auto-generated |
| Exhaustive / partial pattern matching | `sealed` unions + `switch` expressions / `if-case` / `is` on the public case classes |

Freezed 3 removed the generated `.when()` / `.map()` / `.maybeMap()` / `.mapOrNull()` families; union case classes are public (`SuccessLoginState`, not `_SuccessLoginState`) so UI code pattern-matches with plain Dart.

**Forbidden alternatives:** hand-rolled sealed classes (Freezed is the standard), Equatable for BLoC states (fine elsewhere), manual `copyWith`.

---

## BLoC File Structure

`feature_bloc.dart` holds the imports, the generated-file `part`, the `part` for the event/state file and the Bloc class; `feature_event_state.dart` is `part of` the bloc file and holds the event and state unions. Constructor first, fields after (member order: [code_preferences § Class Member Ordering](./code_preferences.md#class-member-ordering)).

```dart
// feature_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_bloc.freezed.dart';  // Generated file
part 'feature_event_state.dart';

class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  FeatureBloc(this._repository) : super(const FeatureState.initial()) {
    on<_RequestedFeatureEvent>(_onRequested);
    on<_SubmittedFeatureEvent>(_onSubmitted);
    on<_RefreshedFeatureEvent>(_onRefreshed);
  }

  final FeatureRepository _repository;

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
    emit(const FeatureState.submitting());

    try {
      await _repository.save(event.data);

      return emit(const FeatureState.success());
    } on AppException catch (e) {
      return emit(FeatureState.failure(e));
    }
  }

  // _onRefreshed: same as _onRequested, minus the loading emit
}
```

```dart
// feature_event_state.dart
part of 'feature_bloc.dart';

@freezed
sealed class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.requested() = _RequestedFeatureEvent;
  const factory FeatureEvent.submitted(Data data) = _SubmittedFeatureEvent;
  const factory FeatureEvent.refreshed() = _RefreshedFeatureEvent;
}

@freezed
sealed class FeatureState with _$FeatureState {
  const FeatureState._();  // Required for getters

  const factory FeatureState.initial() = InitialFeatureState;
  const factory FeatureState.loading() = LoadingFeatureState;
  const factory FeatureState.success(List<Item> items) = SuccessFeatureState;
  const factory FeatureState.failure(AppException exception) = FailureFeatureState;

  bool get isLoading => this is LoadingFeatureState;
}
```

---

## Standard State Patterns

| Pattern | States | Notes |
|---|---|---|
| List / details loading | `initial`, `loading`, `success(data)`, `failure(exception)` | `success` carries `List<Item>` or `Item`; add `hasData`-style getters if widgets repeat the check |
| Operation (create / update / delete) | `initial`, `submitting`, `success()`, `failure(exception)` | `bool get isSubmitting => this is SubmittingItemOperationState;` |
| Persistent data across statuses | nested status — below | filters, selection, pagination |

### Nested Status Pattern (persistent data)

When a state has data that must survive loading/success/failure transitions (selected date, filters, pagination), nest a status union inside a single-constructor state instead of duplicating the fields on every variant:

```dart
@freezed
sealed class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = InitialCalendarStatus;
  const factory CalendarStatus.loading() = LoadingCalendarStatus;
  const factory CalendarStatus.success({required List<Task> tasks}) = SuccessCalendarStatus;
  const factory CalendarStatus.failure({required AppException exception}) = FailureCalendarStatus;
}

@freezed
abstract class CalendarState with _$CalendarState {  // single constructor → abstract
  const factory CalendarState({
    required DateTime selectedDate,  // persists across status changes
    required CalendarStatus status,
  }) = _CalendarState;

  const CalendarState._();

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is LoadingCalendarStatus;
}

@freezed
sealed class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.dateSelected(DateTime date) = _DateSelectedCalendarEvent;
  const factory CalendarEvent.refreshed() = _RefreshedCalendarEvent;  // reloads the current date
}
```

```dart
// Handler: update persistent data AND status; refresh reuses state.selectedDate.
Future<void> _onDateSelected(
  _DateSelectedCalendarEvent event,
  Emitter<CalendarState> emit,
) async {
  emit(state.copyWith(selectedDate: event.date, status: const CalendarStatus.loading()));

  try {
    final tasks = await _repository.getTasksByDate(event.date);

    return emit(state.copyWith(status: CalendarStatus.success(tasks: tasks)));
  } on AppException catch (e) {
    return emit(state.copyWith(status: CalendarStatus.failure(exception: e)));
  }
}
```

```dart
// UI: persistent data read directly, content via an exhaustive switch on the nested status
BlocBuilder<CalendarBloc, CalendarState>(
  builder: (context, state) => Column(
    children: [
      CalendarPicker(selectedDate: state.selectedDate),
      Expanded(
        child: switch (state.status) {
          InitialCalendarStatus() => const SizedBox.shrink(),
          LoadingCalendarStatus() => const CustomCircularProgressIndicator.adaptive(),
          SuccessCalendarStatus(:final tasks) => TasksList(tasks: tasks),
          FailureCalendarStatus(:final exception) => FailureWidget.large(
            exception: exception,
            onRetry: () => context.read<CalendarBloc>().add(const CalendarEvent.refreshed()),
          ),
        },
      ),
    ],
  ),
)
```

**Use** when data must persist across loads (filters, pagination, selection) or a refresh must keep it. **Don't** use for simple CRUD, one-time fetches, or states whose data all changes together.

### Picking the shape

Ask: **does data persist across status changes?** **Shape A**, a flat union (`LoginState` above), when each status carries only its own payload (login flows, one-shot submits, dialogs); **Shape B**, nested status (`CalendarState`), when it does (calendars, filters, tabs, search queries).

| Question | Yes → | No → |
|---|---|---|
| Does the user's input or selection need to survive a reload? | Shape B | Shape A |
| Several independent things loading? | Split into several BLoCs (or model variants, [polymorphism.md](../guides/polymorphism.md)) | Either shape |
| Does the UI render different content across several statuses at once? | Shape B | Shape A |

The outer state's generated `copyWith` updates persistent fields without losing `status`, and the inner status stays a clean union.

---

## Standard Event Patterns

Past tense, one private case class per event:

| Group | Events |
|---|---|
| Fetching | `requested()`, `refreshed()`, `loadMoreRequested()` (pagination) |
| Form / operation | `submitted(ItemData data)`, `fieldChanged(String field, dynamic value)`, `validated()` |
| Selection | `itemSelected(String id)`, `itemDeselected()`, `itemToggled(String id)` |

```dart
const factory ItemEvent.loadMoreRequested() = _LoadMoreRequestedItemEvent;
```

Register a typed `on<_Event>` per event, each with its own handler method (see the file above).

### Event handler rules

| Rule | Reason |
|---|---|
| `return emit(...)` for the final emit | Explicit control flow; prevents accidental double emits |
| Blank line before each `emit(...)` | Visual separation of state transitions |
| Catch `AppException` only | Other errors should crash; wrap raw IO with `withErrorHandling()` |
| Variable names `successState`, `failureState` — never `s` | Readability in pattern matches and casts |
| Handlers that start work (submit, resend, delete) use `transformer: droppable()` from `bloc_concurrency` | A second tap while one runs is ignored; otherwise both run in turn and the request goes out twice |
| Search / debounced input uses `restartable()` and checks `emit.isDone` after each `await` | A newer event cancels the in-flight handler |

### Refreshed event pattern

Always add a `refreshed()` event so retry callbacks never extract data from state; the handler reads `state` directly:

```dart
Future<void> _onRefreshed(_RefreshedCalendarEvent event, Emitter<CalendarState> emit) =>
    _onDateSelected(_DateSelectedCalendarEvent(state.selectedDate), emit);
```

---

## UI Integration

### BlocBuilder (display)

Exhaustive `switch` over the sealed state; the builder returns a non-null `Widget`:

```dart
BlocBuilder<ItemListBloc, ItemListState>(
  builder: (context, state) => switch (state) {
    InitialItemListState() => const SizedBox.shrink(),
    LoadingItemListState() => const CustomCircularProgressIndicator.adaptive(),
    SuccessItemListState(:final items) => ItemListView(items: items),
    FailureItemListState(:final exception) => FailureWidget.large(
      exception: exception,
      onRetry: () => context.read<ItemListBloc>().add(const ItemListEvent.refreshed()),
    ),
  },
)
```

### BlocListener (side effects)

`if-case` / `is` checks for navigation, snackbars, dialogs. User-facing text is localized; exceptions go through `NotificationSnackBar.showExceptionMessage`:

```dart
BlocListener<ItemOperationBloc, ItemOperationState>(
  listener: (context, state) {
    if (state is SuccessItemOperationState) {
      NotificationSnackBar.show(
        context,
        NotificationSnackBar.success(text: Localizer.of(context).itemSaved),
      );
      unawaited(context.router.maybePop());
    }

    if (state case FailureItemOperationState(:final exception)) {
      NotificationSnackBar.showExceptionMessage(context, exception: exception);
    }
  },
  child: const ItemForm(),
)
```

### BlocConsumer (both)

Same two shapes combined: `listener:` with `if-case`, `builder:` with an exhaustive `switch` (`InitialItemState() || LoadingItemState() => …` to group cases). Use it only when listener and builder share the same state branches.

**Don't:** a `BlocBuilder` with a non-exhaustive match (an exhaustive `switch` proves every state returns a `Widget`); legacy Freezed 2 methods; side effects (snackbars, navigation, focus) inside `BlocBuilder`.

### Coordinating multiple BLoCs

BLoCs **never** depend on other BLoCs — coordinate at the UI layer with `BlocListener` (`MultiBlocListener` for more than two):

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthenticatedAuthState) {
      context.read<ProfileBloc>().add(const ProfileEvent.requested());
    }
  },
  child: ...,
)
```

### Pagination and UI models

Pagination is Shape B with `PaginatedData<T>` + `BlocLoadState loadMoreState` in the data-carrying variant — see [pagination.md](../guides/pagination.md) and `TasksSearchBloc`. If a state payload would carry an enum the UI switches on in several places, keep the state on the domain enum/model and map it to a `*UiModel` in the widget (one `from()` switch; never a UI model in state or events) — [polymorphism.md](../guides/polymorphism.md).

---

## State Helper Getters

Add getters to the state for checks widgets repeat (`const State._();` is required). For per-case data prefer a getter built on a `switch`:

```dart
bool get isLoading => this is LoadingItemListState;

List<Item> get items => switch (this) {
  SuccessItemListState(:final items) => items,
  _ => const [],
};
```

The `_ =>` arm is acceptable here because the default is the point; elsewhere never add `default` / `_` to a switch over a sealed type you own ([polymorphism guide](../guides/polymorphism.md)).

---

## Code Generation

After creating or modifying a BLoC:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Freezed generates `copyWith` and `==` / `hashCode` (value equality for correct `BlocBuilder` rebuilds). During a session `fvm flutter pub run build_runner watch --delete-conflicting-outputs` rebuilds on save.

---

## Anti-patterns

| Anti-pattern | Replace with |
|---|---|
| Mutable instance variable on the BLoC class | Move to state |
| `BlocBuilder` returning a nullable Widget | Exhaustive `switch` over the sealed state |
| Legacy Freezed 2 matching (`when`, `maybeMap`, `mapOrNull`, `whenOrNull`) | `switch` / `if-case` |
| Repeated inline `state is LoadingFeatureState` checks | State helper getter |
| `s` as a variable name in pattern matches | `successState`, `failureState` |
| Catching bare `Exception` in handlers | `on AppException catch (e)` |
| UI-localized strings in state | Store `AppException` / domain models; localize in the widget |
| Manual `copyWith`, `==`, `toString` | Let Freezed generate them |
| Two BLoCs with constructor-injected dependency on each other | Coordinate via `BlocListener` |
| Submit / delete handler with the default transformer | `on<...>(_onSubmitted, transformer: droppable())` |

---

## Resources

- [Flutter BLoC Documentation](https://bloclibrary.dev)
- [Freezed Package](https://pub.dev/packages/freezed)
