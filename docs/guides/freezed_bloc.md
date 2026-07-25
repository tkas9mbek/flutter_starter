# Freezed BLoC Guide

## When to read which guide

| You're… | Read |
|---|---|
| Creating your first BLoC in this codebase | [bloc.md](../rules/bloc.md) |
| Picking between flat states and nested status | This guide → "State shape decisions" |
| Wiring a refresh / retry / pagination flow | This guide → "Patterns" |
| Reviewing a BLoC PR | [code_review.md](./code_review.md) → `BLOC-*` rules |

---

## Why Freezed

| Need | Freezed gives you |
|------|-------------------|
| Sealed unions for events / states | `@freezed sealed class` + factory constructors |
| `==` and `hashCode` so `BlocBuilder` works correctly | Auto-generated |
| `copyWith` for compound states | Auto-generated |
| Exhaustive pattern matching | `sealed` unions + Dart `switch` expressions |
| Partial pattern matching | `if-case` / `is` checks on the public case classes |

> **Freezed 3 note:** the generated `.when()` / `.map()` / `.maybeMap()` / `.mapOrNull()` families were removed. Union case classes are now public (`SuccessLoginState`, not `_SuccessLoginState`) so UI code pattern-matches with plain Dart.

**Forbidden alternatives:**
- ❌ Hand-rolled sealed classes — Freezed is the project standard.
- ❌ Equatable for BLoC states — fine elsewhere, but BLoC states use Freezed for the union semantics.
- ❌ Manual `copyWith` methods.

---

## State shape decisions

There are two canonical shapes. Pick by asking: **does data persist across status changes?**

### Shape A — Flat union (no persistent data)

Use when each status carries only its own payload (login flows, one-shot submits, dialogs).

```dart
@freezed
sealed class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial() = InitialLoginState;
  const factory LoginState.loading() = LoadingLoginState;
  const factory LoginState.success() = SuccessLoginState;
  const factory LoginState.failure(AppException exception) = FailureLoginState;

  bool get isLoading => this is LoadingLoginState;
}
```

### Shape B — Nested status (data persists)

Use when data outside the status survives status transitions (calendars, filters, tabs, search queries).

```dart
@freezed
sealed class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = InitialCalendarStatus;
  const factory CalendarStatus.loading() = LoadingCalendarStatus;
  const factory CalendarStatus.success({required List<Task> tasks}) = SuccessCalendarStatus;
  const factory CalendarStatus.failure({required AppException exception}) = FailureCalendarStatus;
}

@freezed
abstract class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    required DateTime selectedDate,
    required CalendarStatus status,
  }) = _CalendarState;

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is LoadingCalendarStatus;
}
```

**Why two classes:** the outer state can use auto-generated `copyWith` to update `selectedDate` without losing `status`, and the inner status remains a clean union.

### Picking the shape

| Question | Yes → | No → |
|----------|-------|------|
| Does the user's input or selection need to survive a reload? | Shape B | Shape A |
| Are there multiple independent things loading? | Split into multiple BLoCs (or use [polymorphism](#polymorphism-and-ui-models)) | Either shape |
| Will the UI render different content across multiple statuses simultaneously? | Shape B | Shape A |

---

## Event handler rules

```dart
Future<void> _onRequested(_RequestedFeatureEvent event, Emitter<FeatureState> emit) async {
  emit(const FeatureState.loading());

  try {
    final items = await _repository.getItems();

    return emit(FeatureState.success(items));
  } on AppException catch (e) {
    return emit(FeatureState.failure(e));
  }
}
```

| Rule | Reason |
|------|--------|
| `return emit(...)` for the final emit | Makes control-flow explicit; prevents accidental double emits |
| Blank line before each `emit(...)` | Visual separation of state transitions |
| Catch `AppException` only | Other errors should crash; wrap raw IO with `withErrorHandling()` |
| Variable names: `successState`, `failureState` — never `s` | Readability in pattern matches and casts |

For nested-status BLoCs, mutate via `copyWith`:

```dart
Future<void> _onDateSelected(_DateSelectedCalendarEvent event, Emitter<CalendarState> emit) async {
  emit(state.copyWith(selectedDate: event.date, status: const CalendarStatus.loading()));

  try {
    final tasks = await _repository.tasksForDate(event.date);

    return emit(state.copyWith(status: CalendarStatus.success(tasks: tasks)));
  } on AppException catch (e) {
    return emit(state.copyWith(status: CalendarStatus.failure(exception: e)));
  }
}
```

---

## Patterns

### Refreshed event pattern

Always add a `.refreshed()` event so retry callbacks never have to extract data from state.

```dart
const factory CalendarEvent.dateSelected(DateTime date) = _DateSelectedCalendarEvent;
const factory CalendarEvent.refreshed() = _RefreshedCalendarEvent;
```

Inside the handler, read from `state` directly:

```dart
Future<void> _onRefreshed(_RefreshedCalendarEvent event, Emitter<CalendarState> emit) =>
    _onDateSelected(_DateSelectedCalendarEvent(state.selectedDate), emit);
```

UI:

```dart
FailureWidget.large(
  exception: failureState.exception,
  onRetry: () => context.read<CalendarBloc>().add(const CalendarEvent.refreshed()),
)
```

### State helper getters

Always add helpers for booleans the UI needs across multiple widgets — never inline an `is` check for the same `bool` in several places.

```dart
bool get isLoading => this is LoadingFeatureState;
bool get hasFailure => this is FailureFeatureState;
```

### BlocListener vs BlocBuilder

| Use | When |
|-----|------|
| `BlocBuilder` + exhaustive `switch (state)` | Rendering UI per state |
| `BlocListener` + `if-case` / `is` checks | Side effects (snackbars, navigation, focus) |
| `BlocConsumer` | Both, when listener and builder share the same state branches |

```dart
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state case FailureLoginState(:final exception)) {
      NotificationSnackBar.showExceptionMessage(context, exception: exception);
    }

    if (state is SuccessLoginState) {
      context.router.replace(const HomeRoute());
    }
  },
  child: BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) => switch (state) {
      LoadingLoginState() => const CustomCircularProgressIndicator.adaptive(),
      InitialLoginState() || SuccessLoginState() || FailureLoginState() =>
        const LoginForm(),
    },
  ),
)
```

**Don't:**
- ❌ `BlocBuilder` with a non-exhaustive match — an exhaustive `switch` lets the compiler prove every state returns a `Widget`.
- ❌ Legacy Freezed 2 methods (`when`, `maybeMap`, `mapOrNull`, `whenOrNull`) — removed in Freezed 3.
- ❌ Side effects in `BlocBuilder` (snackbars, navigation, focus changes).

### Coordinating multiple BLoCs

BLoCs **never** depend on other BLoCs. Coordinate at the UI layer.

```dart
// AuthBloc emits success → trigger ProfileBloc to load.
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthenticatedAuthState) {
      context.read<ProfileBloc>().add(const ProfileEvent.requested());
    }
  },
  child: ...,
)
```

For more than two listeners, use `MultiBlocListener`.

### Pagination (sketch)

Pagination is Shape B with a list and a "loading more" sub-status. The recommended skeleton:

```dart
@freezed
abstract class FeedState with _$FeedState {
  const FeedState._();

  const factory FeedState({
    required List<Post> posts,
    required FeedStatus status,
    required bool hasReachedEnd,
  }) = _FeedState;

  factory FeedState.initial() => const FeedState(
    posts: [],
    status: FeedStatus.initial(),
    hasReachedEnd: false,
  );
}
```

Add events: `.requested()`, `.nextPageRequested()`, `.refreshed()`. Append to `state.posts` on success, set `hasReachedEnd` when the page is short.

---

## Polymorphism and UI models

If a state factory's payload would carry an enum to switch on in the UI, model the variants as a separate Freezed union and let the UI pattern-match on it instead. Keeps the BLoC oblivious to UI presentation rules.

```dart
@freezed
sealed class TaskTileModel with _$TaskTileModel {
  const factory TaskTileModel.completed(Task task) = CompletedTaskTileModel;
  const factory TaskTileModel.overdue(Task task) = OverdueTaskTileModel;
  const factory TaskTileModel.upcoming(Task task) = UpcomingTaskTileModel;
}
```

The mapping `Task → TaskTileModel` lives in a UI-layer mapper, not in the BLoC.

---

## Codegen

After editing any `@freezed` event/state class:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

If you only changed one file, prefer `watch` mode during a session:

```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Anti-patterns checklist

| Anti-pattern | Replace with |
|--------------|--------------|
| Mutable instance variable on the BLoC class | Move to state |
| `BlocBuilder` returning nullable Widget | Exhaustive `switch` over the sealed state |
| Legacy Freezed 2 matching (`when`, `maybeMap`, `mapOrNull`, `whenOrNull`) | Dart `switch` expressions / `if-case` |
| Repeated inline `state is LoadingFeatureState` checks | State helper getter using `is` |
| `s` as variable name in pattern matches | `successState`, `failureState`, etc. |
| Catching bare `Exception` in handlers | `on AppException catch (e)` |
| Storing UI-localized strings in state | Store `AppException` / domain models; localize in widget |
| Manual `copyWith`, `==`, `toString` | Let Freezed generate them |
| Two BLoCs with constructor-injected dependency on each other | Coordinate via `BlocListener` |

---

## See also

- [bloc.md](../rules/bloc.md) — file layout, basic flow
- [code_review.md](./code_review.md) — `BLOC-*` rules
- [exception_handling.md](./exception_handling.md) — what `AppException` looks like and how it reaches `failure` states
- [../ai-context/bloc.md](../ai-context/bloc.md) — AI-friendly cheat sheet
