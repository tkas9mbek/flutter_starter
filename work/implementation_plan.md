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
Status: Completed
- Improve readability in `README.md`, `AGENTS.md`, `CLAUDE.md`.
- Align rules/guide naming and retry-testing guidance.
- Keep docs synchronized with current env naming and CI behavior.

### 7) GitHub Actions CI
Status: Completed
- Add CI workflow for lint + analyze.
- Add parallelized test shards to reduce CI wall-clock time.

### 8) Test runtime optimization
Status: Completed (practical CI/runtime optimization for template scale)
- Reduce retry delays/waits in targeted tests where production-like delays were unnecessary.
- Add CI test sharding for significant wall-clock reduction.
- Rebalance CI shards by feature (`application`, `settings`, `auth`, `profile`, `task`) to reduce longest shard.

Current observed timings (local shard samples):
- `test/features/task`: ~2m05 to ~2m07
- `test/features/auth + test/features/profile`: ~3m04
- `test/features/application + test/features/settings`: ~2m46

Expected CI wall-clock impact:
- Before (single serial suite): ~8 minutes
- After (feature-parallel shards): around longest shard (~2-3 minutes) plus setup overhead.

## Next Iteration Plan Results (2026-05-08 Follow-up)

1. Investigate persistent per-file test teardown/startup pauses: Completed
   - Confirmed repeated delays are still present with and without `--no-test-assets`.
   - Indicates overhead is mostly per-suite startup/teardown and Flutter test harness behavior, not asset bundling.
2. Reduce file-fragmentation impact in test invocation: Completed
   - CI is now split by feature shards to reduce longest single job wall-clock.
3. Add optional stricter lint gate: Completed
   - Added dedicated strict-lint job behind `workflow_dispatch` input `strict_lint=true`.
4. Docs consistency sweep: Completed
   - Updated docs to reflect strict lint mode and current CI strategy.

## Next Iteration Plan Results (2026-05-09 Follow-up)

1. Reduce test fixture I/O overhead: Completed
   - Converted JSON mock model helpers to load fixture files once per test process and reuse parsed models.
   - Preserved JSON + `fromJson` based test data strategy while removing repeated disk reads.
2. Tighten async waits in retry-based tests: Completed
   - Reduced conservative `blocTest.wait` values from 300ms to 120ms in retry scenarios with 10ms retry delay.
   - Replaced a fixed 10ms settings integration sleep with a zero-duration async tick.
3. Trim CI command overhead: Completed
   - Added `--no-pub` to `flutter analyze` and shard test invocations in CI after dependency install.
4. Runtime optimization status: Updated
   - CI wall-clock is now improved via sharding + reduced per-test overhead from fixture caching and tighter waits.
   - Further deep runtime improvements would require broader test architecture changes (merging very small suites or replacing some integration coverage with faster contract-level tests).

## Next Iteration Plan Results (2026-05-10 Follow-up)

1. Warning-level lint debt cleanup: Completed
   - Fixed all custom-lint warning-level findings (including hardcoded color usage and BuildContext field storage).
   - Current `custom_lint` warning count is zero.
2. Strict lint gate stabilization: Completed
   - Strict workflow now runs with fatal warnings and non-fatal infos (`dart run custom_lint --no-fatal-infos`).
   - Keeps style guidance visible while preventing noisy info-only failures.
3. Runtime optimization closure: Completed
   - Remaining observed delays are primarily Flutter test harness/file transition costs.
   - With sharded CI, fixture caching, and reduced waits already applied, additional gains require architecture tradeoffs not suitable for the template baseline.

## Acceptance Criteria
- CI passes on pull requests.
- Analyzer passes.
- Full test suite passes.
- Reconfigure flow is race-safe and idempotent.
- Shared unregister helper remains single-source in `AppModule`.
