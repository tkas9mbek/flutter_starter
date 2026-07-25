# BLoC — AI Context

Concise rules. Full guide: [../guides/freezed_bloc.md](../guides/freezed_bloc.md).

## Required setup

- `@freezed sealed class` for **all** events and states (unions); `@freezed abstract class` for single-constructor state classes.
- State case classes are public (`SuccessLoginState`); event case classes stay private (`_SubmittedLoginEvent`).
- Freezed 3: no generated `when`/`map`/`maybeMap`/`mapOrNull` — pattern-match with Dart `switch` / `if-case`.
- Run `build_runner` after editing event/state classes.
- File: `bloc/{feature}_bloc.dart` contains event + state + bloc.

## Creation & DI

- Register every screen bloc in its feature module (`configs/`):
  `..registerFactory(() => MyBloc(getIt<MyRepository>()))` plus a matching
  `unregisterIfRegistered<MyBloc>` callback.
- Resolve it at the screen — never construct feature blocs manually in UI:
  `BlocProvider(create: (context) => getIt<MyBloc>()..add(const MyEvent.started()))`.
- Documented exception: the app-shell blocs/cubits in `application.dart`
  (`AuthBloc`, `EnvironmentCubit`, `LanguageCubit`, `ThemeCubit`) are
  constructed at the composition root because they drive, or must survive,
  DI reconfiguration and belong to no feature module.

## State pattern (simple)

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

## State pattern (data persists across status changes)

Use **nested status**:

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

## Event handler rules

1. `return emit(state)` for the final emit.
2. Blank line before every `emit(...)`.
3. Variable names: `successState`, `failureState` — never `s`.
4. Catch `AppException`, never bare `Exception`.

```dart
Future<void> _onRequested(_RequestedMyEvent event, Emitter<MyState> emit) async {
  emit(const MyState.loading());

  try {
    final data = await _repository.getData();

    return emit(MyState.success(data));
  } on AppException catch (e) {
    return emit(MyState.failure(e));
  }
}
```

## Streaming states (real-time updates)

Two sanctioned shapes — both clean up in `close()`:

```dart
// A. Subscription → events (see AuthBloc): react to a repository stream by
// dispatching events, so all emits still flow through handlers.
MyBloc(this._repository) : super(const MyState.initial()) {
  _subscription = _repository.updates.listen((_) => add(const MyEvent.refreshed()));
  on<_RefreshedMyEvent>(_onRefreshed);
}

@override
Future<void> close() async {
  await _subscription?.cancel();

  return super.close();
}

// B. emit.forEach: keep the handler alive for the stream's lifetime.
on<_WatchStartedMyEvent>(
  (event, emit) => emit.forEach(
    _repository.watchItems(),
    onData: (items) => MyState.success(items),
  ),
);
```

## Debounced / restartable handlers

- Use `bloc_concurrency` transformers: `on<_QueryChangedEvent>(_onQueryChanged, transformer: restartable())` cancels the in-flight handler when a newer event arrives (see `TasksSearchBloc`).
- After every `await` in a restartable handler, guard with `if (emit.isDone) return;` before emitting.

## Two-file layout

Larger blocs split into `{name}_bloc.dart` (class + handlers, holds `part` directives) and `{name}_event_state.dart` (`part of '{name}_bloc.dart';` with events + states). See `otp_bloc.dart`, `tasks_search_bloc.dart`, `remote_configs_bloc.dart`.

## Wizard / multi-step form state

Single data-class state accumulating selections via `copyWith`, a `canSubmit` getter gating submit, and `submitting`/`exception`/result fields. Prefer this over a sealed union when partial selections must persist across steps (multi-screen checkout, booking); for a one-screen form validated on submit, a standard sealed union fed by one `submitted(form)` event is enough (see `TaskCreationBloc`).

## UI consumption

- Exhaustive `switch (state)` expression/statement in `BlocBuilder` — every case returns a `Widget`.
- `if (state case FailureLoginState(:final exception))` or `state is SuccessLoginState` for side-effects in `BlocListener`.
- `switch (state.status)` for nested status (exhaustive over the sealed status union).
- Add a `.refreshed()` event so retry never extracts data from state.

## Forbidden

- ❌ `BlocBuilder` doing side-effects (snackbars, navigation).
- ❌ Injecting one BLoC into another.
- ❌ Manual `==` / `hashCode` (Freezed handles it).
- ❌ Storing UI models in BLoC state — store domain models or `AppException`.
