# Architecture — AI Context

Concise rules. For full reasoning see [../guides/architecture.md](../guides/architecture.md).

## Layers

```
Presentation (Flutter, BLoC) → Domain (Repo, AbstractDS, Model) ← Data (DS impl, ApiClient)
```

- **Domain** = contracts only. No Flutter, no horizontal deps.
- **Data** implements Domain abstractions. No Flutter.
- **Presentation** is the only layer that imports Flutter.

## Hard rules

| # | Rule |
|---|------|
| A1 | Repositories are **concrete facades** over abstract DataSources. Do not make repositories abstract. |
| A2 | Abstract DataSource lives in `domain/`. Implementations (remote/local/mock) live in `data/`. |
| A3 | BLoCs **never** depend on other BLoCs. Coordinate at UI layer (`BlocListener`, route extras). |
| A4 | Repositories **never** depend on other repositories. |
| A5 | All dependencies are wired via GetIt modules (`extends AppModule`) under `configs/`. |
| A6 | All errors crossing the data → presentation boundary are `AppException` (sealed, Freezed). |
| A7 | All user-facing strings go through `Localizer.of(context)`. |
| A8 | All colors / typography go through `ThemeProvider.of(context)`. |

## Decisions

- Need cross-cutting concerns on a repo call? Compose in the DI module from a single local `base = const RawRepositoryExecutor().withErrorHandling()` and inject via constructor params; caching is the `RepositoryCache` collaborator. See [repository_executor.md](repository_executor.md).
- Need a new exception type? Add sealed factory + `@ExceptionUiConfig` → run generator.
- Need shared widget? Check `starter_uikit` first. Check `starter_toolkit` for utilities.

## Code generation

All generated files are produced by a tool — never hand-edit them; rerun the generator instead.

| Tool | Command | Run after changing | Output |
|------|---------|--------------------|--------|
| build_runner | `fvm flutter pub run build_runner build --delete-conflicting-outputs` | Router configs, Freezed classes (incl. BLoC events/states), JSON models | `*.gr.dart`, `*.freezed.dart`, `*.g.dart` |
| Exception mapper | `dart run utils/generators/generate_exception_mapper.dart` | `AppException` sealed classes / `@ExceptionUiConfig` | Exception mapper + decorator |
| intl_utils | `fvm flutter --no-color pub global run intl_utils:generate` | ARB files (`intl_en.arb`, `intl_ru.arb`) | `l10n/generated/` (`Localizer`, `ToolkitLocalizer`, `UikitLocalizer`) |
| spider | `spider build` in `packages/starter_uikit` | Assets in `packages/starter_uikit/assets/` (icons, images, fonts) | `lib/resources/` (`UiSvgIcons`, `Images`, fonts) |

## Feature folder

```
lib/features/{feature}/
├── data/        # DS impl
├── domain/      # AbstractDS + Repository
├── model/       # domain models
├── configs/     # GetIt module
└── ui/          # subfeature folders ONLY, e.g. list/, details/
```

`ui/` never holds a flat `bloc/`/`screen/`/`widget/` or loose files: every screen lives in a logic-separated subfeature folder (`list/`, `details/`, `create/`) containing `bloc/`, `screen/`, `widget/` (+ `model/`) with at least 2 files (bloc + screen, or a complex screen with widgets). Cross-subfeature widgets go to `starter_uikit` or the owning subfeature.
