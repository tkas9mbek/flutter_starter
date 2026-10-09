# Architecture — AI Context

Concise rules. Full reasoning: [../guides/architecture.md](../guides/architecture.md). Hard rules `A1`–`A8` (concrete repos over abstract DataSources, no BLoC→BLoC / repo→repo deps, GetIt modules, `AppException`, `Localizer`, `ThemeProvider`) live in the [AGENTS.md](../../AGENTS.md) Architecture table.

## Layers

```
Presentation (Flutter, BLoC) → Domain (Repo, AbstractDS, Model) ← Data (DS impl, ApiClient)
```

- **Domain** = contracts only. No Flutter, no horizontal deps.
- **Data** implements Domain abstractions. No Flutter.
- **Presentation** is the only layer that imports Flutter.

## Decisions

- Cross-cutting concerns on a repo call → compose in the DI module from a single local `base = const RawRepositoryExecutor().withErrorHandling()`, inject via constructor params. Baseline is `.withErrorHandling()`; append `.withRetry(maxRetries: 3, retryDelay: ...)` only for idempotent reads (today `ProfileRepository`, `PushTokenRepository`, `RemoteConfigRepository`). Caching is the `RepositoryCache` collaborator (`InMemoryRepositoryCache` in `starter_toolkit`, no consumer yet). See [repository_executor.md](repository_executor.md).
- Offline twin for a DataSource → `data/mock/` + `mockOrProd(mock:, prod:)` ([mocking.md](mocking.md)).
- New exception type → `final class` subtype of `AppException` with `@ExceptionUiConfig` → run generator ([exception.md](exception.md)).
- Shared widget/util → check `starter_uikit` / `starter_toolkit` first.

## Code generation

Generated files are never hand-edited — rerun the generator.

| Tool | Command | Run after changing | Output |
|------|---------|--------------------|--------|
| build_runner | `fvm flutter pub run build_runner build --delete-conflicting-outputs` | Router configs, Freezed classes (incl. BLoC events/states), JSON models | `*.gr.dart`, `*.freezed.dart`, `*.g.dart` |
| Exception mapper | `dart run utils/generators/generate_exception_mapper.dart` | `AppException` classes / `@ExceptionUiConfig` | Exception mapper + decorator |
| intl_utils | `fvm flutter --no-color pub global run intl_utils:generate` | ARB files (`intl_en.arb`, `intl_ru.arb`) | `l10n/generated/` (`Localizer`, `ToolkitLocalizer`, `UikitLocalizer`) |
| spider | `spider build` in `packages/starter_uikit` | Assets in `packages/starter_uikit/assets/` | `packages/starter_uikit/lib/resources/` (`UiSvgIcons`, `Images`, fonts) |

## Feature folder

```
lib/features/{feature}/
├── data/        # DS impl (api/local); mock/ = Mock*DataSource + scenarios
├── domain/      # AbstractDS + Repository
├── model/       # domain models
├── configs/     # GetIt module
└── ui/          # subfeature folders ONLY, e.g. list/, details/
```

`ui/` never holds a flat `bloc/`/`screen/`/`widget/` or loose files: each screen lives in a logic-separated subfeature folder (`list/`, `details/`, `create/`) with `bloc/`, `screen/`, `widget/` (+ `model/`), ≥2 files (bloc + screen, or a complex screen with widgets). Cross-subfeature widgets go to `starter_uikit` or the owning subfeature.
