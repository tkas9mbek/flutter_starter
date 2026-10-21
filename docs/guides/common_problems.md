# Common Problems

Recipes for problems that keep coming back. Each one gives the symptom, the fix, and where to copy the code from.

Add a recipe here when you solve the same problem a second time.

| Symptom | Recipe |
|---|---|
| User logs out, reopens the app, and is signed in again | [1. Sign-out must not wait for the server](#1-sign-out-must-not-wait-for-the-server) |
| One screen changes data, another screen still shows the old data | [2. Other screens show old data](#2-other-screens-show-old-data) |
| A form error stays after the user fixes the field, or shows too early | [3. Form errors](#3-form-errors) |
| Text overflows or breaks mid-word at large accessibility text sizes | [4. Large text](#4-large-text) |

---

## 1. Sign-out must not wait for the server

**Symptom.** The user taps Log Out and sees the login screen. After a restart they are signed in again. The logout request failed, so the code never reached the line that deletes the token.

**Fix.** Clear local state first. Send the server call in parallel, do not wait for it, and ignore its failure. The server call gets the token it needs as an argument, because storage is already empty when the request goes out.

```dart
Future<void> logout() async {
  _controller.add(AuthStatus.unauthenticated);

  final token = await _localDataSource.getToken();

  if (token != null) {
    unawaited(_revokeOnServer(token)); // best effort, never blocks
  }

  await _localDataSource.clearStorage();
}
```

The auth interceptor in `data_module.dart` keeps an explicit `Authorization` header instead of reading storage, so the request still carries the old token.

**Where.** `AuthRepository.logout`, tests in `test/features/auth/integration/integration_test.dart` (`logout flow`).

**Same rule for** anything where the user's intent must win over the network: clearing a session, wiping a cache, revoking a push token.

---

## 2. Other screens show old data

**Symptom.** The user deletes a task on the details screen. The list behind it still shows the task until they pull to refresh.

Each screen builds its own bloc, and blocs never talk to each other (`A3`). Something shared has to tell the other screens. Pick the recipe by who needs to know.

| Who needs to know | Use |
|---|---|
| Several screens show the same data, or you cannot tell who is open | **A. Repository stream** (default) |
| Only the screen that opened this one | **B. Pop with a result** |

Use one recipe per piece of data. Both on the same data reloads twice.

### A. Repository stream

The repository announces every successful change. Every bloc that shows the data listens and reloads.

```dart
// Repository — announce only after success
final _changes = StreamController<void>.broadcast();
Stream<void> get changes => _changes.stream;

Future<void> deleteTask(String id) async {
  await _executor.execute(() => _dataSource.deleteTask(id));
  _changes.add(null);
}

Future<void> dispose() => _changes.close();
```

```dart
// Bloc — a change becomes a normal refresh event
_changesSubscription = _repository.changes.listen(
  (_) => add(const TasksListEvent.refreshed()),
);

@override
Future<void> close() async {
  await _changesSubscription.cancel();

  return super.close();
}
```

Rules:

- The repository **must be one shared instance**: `registerLazySingleton`, with `dispose()` in the module's unregister callback. With `registerFactory` every bloc gets its own stream and hears nothing.
- Screens do not reload by hand after a create or delete. The stream does it; a manual reload on top makes two requests.
- Reuse the existing `.refreshed()` event. Do not add a second reload path.
- A bloc that should not jump on a change, such as search with no results shown, checks its state before adding the event.

**Where.** `TaskRepository.changes`; listeners in `TasksListBloc`, `CalendarBloc`, `TasksSearchBloc`; tests in `test/features/task/integration/integration_test.dart` (`change propagation`).

### B. Pop with a result

When there is no stream, the screen that changes something pops with `true`. The screen that opened it reloads when it gets `true`.

```dart
// Edit screen — on success
unawaited(context.router.maybePop(true));
```

```dart
// Screen that opened it
final changed = await context.router.push<bool>(const ProfileEditRoute());

if (!context.mounted) {
  return;
}

if (changed ?? false) {
  context.read<ProfileBloc>().add(const ProfileEvent.refreshed());
}
```

Pop `true` only when something changed. A plain back press returns `null`, so no reload. This does not reach screens further back in the stack. If a second screen needs the news, move to recipe A.

---

## 3. Form errors

**Symptom.** The user fixes a field, but its red error stays until they press submit again. Or the field shows an error before the user has submitted anything.

**Fix.** Use `AppForm` from `starter_uikit` instead of a bare `FormBuilder`.

- Before the first submit the form stays quiet.
- After the first submit each field re-validates as the user edits it.
- `validateField(name)` checks one field for a button that needs only part of the form, such as "Sign in with code". It keeps re-validating that field and leaves the others quiet.

```dart
final formKey = GlobalKey<AppFormState>();

void onSubmitted(BuildContext context) {
  if (formKey.currentState!.saveAndValidate()) {
    final form = LoginForm.fromForm(formKey.currentState!.value);
    context.read<LoginBloc>().add(LoginEvent.submitted(form));
  }
}

AppForm(
  key: formKey,
  initialValue: const {...}, // same as FormBuilder
  child: ...,
)
```

Notes for field widgets:

- Do not call `setState` straight from a validator. Auto-validation runs validators while the field builds, and Flutter rejects it. `AppTextField.showError` shows how to defer it.

**Where.** `packages/starter_uikit/lib/widgets/form/app_form.dart` (gallery: "Form fields"), used by login, registration and task create. Tests in `packages/starter_uikit/test/widgets/form/app_form_test.dart`.

---

## 4. Large text

**Symptom.** With the largest iOS text size, a screen shows overflow stripes, a title wraps one letter per line, or a button label is cut off.

**Fix.** Do not fix sizes; let text grow, and change the layout when it gets big.

- **Fixed heights are minimums.** Give a button `minimumSize`, not a `SizedBox(height:)`. `AppBaseButton` does this.
- **Stack side-by-side rows.** When `context.hasLargeText` is true, put the value or badge under the title instead of next to it (`AppListTile`, the calendar card).
- **Clamp small chrome.** Tab labels, the calendar day chips and the time column stay readable at 1.3x and cannot grow with the page: wrap them in `MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3)`.
- **Let headers wrap.** Use `Wrap` instead of `Row` for a label plus a count.
- **Debug banners ignore text scale.** They are tools, not content.

Test it by pumping the widget under `MediaQuery(data: MediaQueryData(textScaler: TextScaler.linear(3)), ...)` and checking `tester.takeException()` is null. On a simulator: `xcrun simctl ui booted content_size accessibility-extra-extra-extra-large`, and reset with `large`.

**Where.** `packages/starter_uikit/lib/utils/text/text_scale_context.dart`, `AppListTile`, `BottomNavItem`, `TaskTimelineContentCard`.

---

Next: hit something that fits none of these? Solve it, then add the recipe above in the same pull request.
