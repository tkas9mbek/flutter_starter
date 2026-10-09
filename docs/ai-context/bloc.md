# BLoC — AI Context

Concise rules. Full guide: [../guides/freezed_bloc.md](../guides/freezed_bloc.md).

## Required setup

- `@freezed sealed class` for **all** events and states (unions); `@freezed abstract class` for single-constructor state classes.
- State case classes public (`SuccessLoginState`); event case classes private (`_SubmittedLoginEvent`).
- Freezed 3: no generated `when`/`map`/`maybeMap`/`mapOrNull` — pattern-match with `switch` / `if-case`. Run `build_runner` after editing events/states.
- `bloc/{feature}_bloc.dart` holds event + state + bloc (or the two-file layout below).

## Creation & DI

- Register every screen bloc in its feature module (`configs/`): `..registerFactory(() => MyBloc(getIt<MyRepository>()))` + a matching `unregisterIfRegistered<MyBloc>` callback.
- Resolve at the screen, never construct feature blocs in UI: `BlocProvider(create: (context) => getIt<MyBloc>()..add(const MyEvent.started()))`.
- Exception: app-shell blocs/cubits in `application.dart` (`AuthBloc`, `EnvironmentCubit`, `LanguageCubit`, `ThemeCubit`) are built at the composition root — they drive or survive DI reconfiguration and belong to no feature module.

## State patterns

Simple union:

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

Data persists across status changes → **nested status** (`CalendarStatus` sealed union with `initial/loading/success({required List<Task> tasks})/failure({required AppException exception})` inside a state class):

```dart
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

Wizard / multi-step form: single data-class state accumulating selections via `copyWith`, a `canSubmit` getter, and `submitting`/`exception`/result fields — when partial selections must persist across steps. A one-screen form validated on submit needs only a sealed union + one `submitted(form)` event (see `TaskCreationBloc`).

## Event handler rules

1. `return emit(state)` for the final emit.
2. Blank line before every `emit(...)`.
3. Names `successState`, `failureState` — never `s`.
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

## Streams

Two sanctioned shapes, both clean up in `close()`:

```dart
// A. Subscription → events (AuthBloc): emits still flow through handlers.
MyBloc(this._repository) : super(const MyState.initial()) {
  _subscription = _repository.updates.listen((_) => add(const MyEvent.refreshed()));
  on<_RefreshedMyEvent>(_onRefreshed);
}

@override
Future<void> close() async {
  await _subscription?.cancel();

  return super.close();
}

// B. emit.forEach: handler lives as long as the stream.
on<_WatchStartedMyEvent>(
  (event, emit) => emit.forEach(_repository.watchItems(), onData: MyState.success),
);
```

## Debounced / restartable handlers

- `bloc_concurrency` transformers: `on<_QueryChangedEvent>(_onQueryChanged, transformer: restartable())` cancels the in-flight handler on a newer event (`TasksSearchBloc`).
- After every `await` in a restartable handler: `if (emit.isDone) return;` before emitting.

## Two-file layout

Larger blocs: `{name}_bloc.dart` (class + handlers, `part` directives) + `{name}_event_state.dart` (`part of '{name}_bloc.dart';`). See `otp_bloc.dart`, `tasks_search_bloc.dart`, `remote_configs_bloc.dart`.

## UI consumption

- `BlocBuilder`: exhaustive `switch (state)` — every case returns a `Widget`; `switch (state.status)` for nested status.
- `BlocListener` side-effects: `if (state case FailureLoginState(:final exception))` or `state is SuccessLoginState`.
- Retry through a `.refreshed()` event, never by extracting data from state.

## Forbidden

- ❌ `BlocBuilder` doing side-effects (snackbars, navigation).
- ❌ Injecting one BLoC into another.
- ❌ Manual `==` / `hashCode` (Freezed handles it).
- ❌ UI models in BLoC state — store domain models or `AppException`.
