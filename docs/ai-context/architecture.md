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

- Need cross-cutting concerns on a repo call? Wrap with `RawRepositoryExecutor().withErrorHandling().withRetry().withCaching()`.
- Need a new exception type? Add sealed factory + `@ExceptionUiConfig` → run generator.
- Need shared widget? Check `starter_uikit` first. Check `starter_toolkit` for utilities.

## Feature folder

```
lib/features/{feature}/
├── data/        # DS impl
├── domain/      # AbstractDS + Repository
├── model/       # domain models
├── configs/     # GetIt module
└── ui/          # bloc/, screen/, widget/
```

Complex features subdivide `ui/` by flow (`list/`, `details/`, `operation/`).
