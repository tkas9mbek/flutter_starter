# Flutter Starter Improvement Plan

Date: 2026-05-08

## Goal
Stabilize and modernize the template package by fixing the lint pipeline, making runtime environment switching safe, hardening interceptor/error behavior, reducing template leakage, improving docs, adding CI, and reducing test wall-clock time.

## Scope Breakdown

### 1) Lint pipeline reliability
Status: Completed
- Pin analyzer/custom_lint compatibility so `custom_lint` runs cleanly in CI and locally.
- Keep warnings/info non-fatal for now to preserve backward compatibility.

### 2) Runtime environment switching safety
Status: Completed
- Prevent no-op environment reconfigure churn.
- Serialize reconfigure calls to avoid concurrent DI races.
- Ensure env equality compares all meaningful fields.

### 3) Interceptor and error-flow cleanup
Status: Completed
- Normalize `DioException` handling through interceptor handlers instead of throwing directly inside interceptor callbacks.
- Harden auth refresh flow for 401/non-401 behavior and logout paths.

### 4) DI and auth re-registration safety
Status: Completed
- Centralize unregister helper in abstract module (`AppModule.unregisterIfRegistered`).
- Remove duplicated unregister logic across modules.
- Make re-registration idempotent and safe for singleton/factory lifecycles.

### 5) Remove template leakage + improve bootstrap
Status: Completed
- Replace product-specific store references with template placeholders.
- Introduce a shared app version constant used by settings UI.
- Improve README bootstrap checklist and quick-start flow.

### 6) Documentation drift/readability
Status: Completed (major), Ongoing (minor consistency)
- Improve readability in `README.md`, `AGENTS.md`, `CLAUDE.md`.
- Align rules/guide naming and retry-testing guidance.
- Keep docs synchronized with current env naming and CI behavior.

### 7) GitHub Actions CI
Status: Completed
- Add CI workflow for lint + analyze.
- Add parallelized test shards to reduce CI wall-clock time.

### 8) Test runtime optimization
Status: Partially Completed
- Reduce retry delays/waits in targeted tests where production-like delays were unnecessary.
- Add CI test sharding for significant wall-clock reduction.

Current observed timings (local shard samples):
- `test/features/task`: ~2m05s
- `test/features/auth + test/features/profile`: ~3m04s
- `test/features/application + test/features/settings`: ~2m46s

Expected CI wall-clock impact:
- Before (single serial suite): ~8 minutes
- After (parallel shards): around longest shard (~3-4 minutes) plus setup overhead.

## Next Iteration Plan

1. Investigate persistent per-file test teardown/startup pauses (likely test process overhead).
2. Evaluate reducing file-fragmentation in test invocation while preserving maintainability.
3. Add optional stricter lint gate (warnings as fatal) behind a dedicated CI job or opt-in mode.
4. Continue docs consistency sweep for any remaining stale wording.

## Acceptance Criteria
- CI passes on pull requests.
- Analyzer passes.
- Full test suite passes.
- Reconfigure flow is race-safe and idempotent.
- Shared unregister helper remains single-source in `AppModule`.
