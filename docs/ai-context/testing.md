# Testing — AI Context

Concise rules. Full guide: [../guides/testing.md](../guides/testing.md).

## Layout

```
test/features/{feature}/
├── assets/        # JSON fixtures
├── model/         # mock builders that call fromJson
├── data/          # repo + DS unit tests
├── bloc/          # BLoC unit tests
└── integration/   # full stack, only ApiClient mocked
```

## Required practices

| # | Rule |
|---|------|
| T1 | Build mocks via JSON + `fromJson` — never construct domain models inline. |
| T2 | One BLoC unit test per event covering: success, empty, failure. |
| T3 | Integration tests mock only `ApiClient`. Everything else is real. |
| T4 | Register fallback values for **every** custom type used inside `any(named:)` matchers. |
| T5 | `blocTest` for retry decorators must set `wait` based on retry settings (for example `8s` for `2s × 3`, or `300ms` for `10ms × 3`). |

## Mocktail fallbacks

```dart
setUpAll(() {
  registerFallbackValue(HttpMethod.get);
  registerFallbackValue(_fakeFromJson);
});

User _fakeFromJson(Map<String, dynamic> json) => User.fromJson(json);
```

Without this you'll see `MissingStubError` on `any(named: 'method')` or `any(named: 'fromJson')`.

## blocTest skeleton

```dart
blocTest<UserBloc, UserState>(
  'emits [loading, success] on requested',
  build: () => UserBloc(repository: mockRepository),
  act: (bloc) => bloc.add(const UserEvent.requested()),
  expect: () => [
    const UserState.loading(),
    UserState.success([...]),
  ],
);
```

## Don't

- ❌ Hand-rolled `Mock<Repository>` with manual when/then for every method — use `mocktail`.
- ❌ Sleep-based tests. Use `wait:` for retry/debounce, `fakeAsync` otherwise.
- ❌ Asserting on `state.toString()`. Compare states via Freezed's generated equality.
