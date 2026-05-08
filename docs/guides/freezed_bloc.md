# Freezed BLoC Guide

> **AI Context**: Deep dive on the BLoC + Freezed patterns used across this project. Read [bloc.md](./bloc.md) first for the file-layout basics — this guide focuses on state shapes, decisions, and patterns the basics don't cover.

## When to read which guide

| You're… | Read |
|---|---|
| Creating your first BLoC in this codebase | [bloc.md](./bloc.md) |
| Picking between flat states and nested status | This guide → "State shape decisions" |
| Wiring a refresh / retry / pagination flow | This guide → "Patterns" |
| Reviewing a BLoC PR | [code_review.md](./code_review.md) → `BLOC-*` rules |

---

## Why Freezed

| Need | Freezed gives you |
|------|-------------------|
| Sealed unions for events / states | `@freezed` + factory constructors |
| `==` and `hashCode` so `BlocBuilder` works correctly | Auto-generated |
| `copyWith` for compound states | Auto-generated |
| Exhaustive pattern matching | `.when(...)` |
| Partial pattern matching | `.maybeMap(...)`, `.mapOrNull(...)` |

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
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial() = _InitialLoginState;
  const factory LoginState.loading() = _LoadingLoginState;
  const factory LoginState.success() = _SuccessLoginState;
  const factory LoginState.failure(AppException exception) = _FailureLoginState;

  bool get isLoading => this is _LoadingLoginState;
}
```

### Shape B — Nested status (data persists)

Use when data outside the status survives status transitions (calendars, filters, tabs, search queries).

```dart
@freezed
class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = _InitialCalendarStatus;
  const factory CalendarStatus.loading() = _LoadingCalendarStatus;
  const factory CalendarStatus.success({required List<Task> tasks}) = _SuccessCalendarStatus;
  const factory CalendarStatus.failure({required AppException exception}) = _FailureCalendarStatus;
}

@freezed
class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    required DateTime selectedDate,
    required CalendarStatus status,
  }) = _CalendarState;

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is _LoadingCalendarStatus;
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
| Variable names: `successState`, `failureState` — never `s` | Readability in `maybeMap` / `mapOrNull` lambdas |

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
FailureWidgetLarge(
  exception: failureState.exception,
  onRetry: () => context.read<CalendarBloc>().add(const CalendarEvent.refreshed()),
)
```

### State helper getters

Always add helpers for booleans the UI needs across multiple widgets — never inline `maybeWhen` for a `bool`.

```dart
bool get isLoading => this is _LoadingFeatureState;
bool get hasFailure => this is _FailureFeatureState;
```

### BlocListener vs BlocBuilder

| Use | When |
|-----|------|
| `BlocBuilder` + `maybeMap(orElse: ...)` | Rendering UI per state |
| `BlocListener` + `mapOrNull(...)` | Side effects (snackbars, navigation, focus) |
| `BlocConsumer` | Both, when listener and builder share the same state branches |

```dart
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) => state.mapOrNull(
    failure: (s) => NotificationSnackBar.showExceptionMessage(context, exception: s.exception),
    success: (_) => context.router.replace(const HomeRoute()),
  ),
  child: BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) => state.maybeMap(
      orElse: () => const LoginForm(),
      loading: (_) => const CustomCircularProgressIndicator(),
    ),
  ),
)
```

**Don't:**
- ❌ `BlocBuilder` with `mapOrNull` — returns `Widget?` and Flutter will throw.
- ❌ `BlocListener` with `maybeMap(orElse: () {})` — use `mapOrNull` to express "ignore other states".
- ❌ Side effects in `BlocBuilder` (snackbars, navigation, focus changes).

### Coordinating multiple BLoCs

BLoCs **never** depend on other BLoCs. Coordinate at the UI layer.

```dart
// AuthBloc emits success → trigger ProfileBloc to load.
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) => state.mapOrNull(
    authenticated: (_) => context.read<ProfileBloc>().add(const ProfileEvent.requested()),
  ),
  child: ...,
)
```

For more than two listeners, use `MultiBlocListener`.

### Pagination (sketch)

Pagination is Shape B with a list and a "loading more" sub-status. The recommended skeleton:

```dart
@freezed
class FeedState with _$FeedState {
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
| `BlocBuilder` returning nullable Widget | `maybeMap` with `orElse` |
| `BlocListener` with empty `orElse: () {}` | `mapOrNull` |
| Inline `state.maybeWhen(...)` for a `bool` | State helper getter using `is` |
| `s` as variable name in pattern matches | `successState`, `failureState`, etc. |
| Catching bare `Exception` in handlers | `on AppException catch (e)` |
| Storing UI-localized strings in state | Store `AppException` / domain models; localize in widget |
| Manual `copyWith`, `==`, `toString` | Let Freezed generate them |
| Two BLoCs with constructor-injected dependency on each other | Coordinate via `BlocListener` |

---

## See also

- [bloc.md](./bloc.md) — file layout, basic flow
- [code_review.md](./code_review.md) — `BLOC-*` rules
- [exception_handling.md](./exception_handling.md) — what `AppException` looks like and how it reaches `failure` states
- [../ai-context/bloc.md](../ai-context/bloc.md) — AI-friendly cheat sheet
