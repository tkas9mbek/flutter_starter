# BLoC — AI Context

Concise rules. Full guide: [../guides/freezed_bloc.md](../guides/freezed_bloc.md).

## Required setup

- `@freezed` for **all** events and states.
- Run `build_runner` after editing event/state classes.
- File: `bloc/{feature}_bloc.dart` contains event + state + bloc.

## State pattern (simple)

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

## State pattern (data persists across status changes)

Use **nested status**:

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

## UI consumption

- `state.maybeMap(...)` for partial matching in `BlocBuilder`.
- `state.mapOrNull(...)` for side-effects in `BlocListener`.
- `state.when(...)` for nested status (exhaustive).
- Add a `.refreshed()` event so retry never extracts data from state.

## Forbidden

- ❌ `BlocBuilder` doing side-effects (snackbars, navigation).
- ❌ Injecting one BLoC into another.
- ❌ Manual `==` / `hashCode` (Freezed handles it).
- ❌ Storing UI models in BLoC state — store domain models or `AppException`.
