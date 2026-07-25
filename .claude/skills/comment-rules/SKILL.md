---
name: comment-rules
description: Project rules for code comments and doc comments in flutter_starter.
---

- Max 120 characters per line.
- Skip self-explanatory logic. `_onRequestedMore` explains itself.
- Never restate a variable's value — it goes stale and causes shotgun surgery.
- Explain WHY and non-obvious behavior: spec references, races, invariants,
  platform quirks. Never narrate what the code already shows.
- Good: "Measures the indicator placeholder's center so the shrinking circle can
  land exactly on it."
- No location-justification comments ("lives in core so other features can use it").
- `///` doc comments only for public APIs in `starter_toolkit` / `starter_uikit` /
  `starter_lints` — 1-3 lines, brief description only.
- Where two files must change together (e.g. a generator and its output, or two
  packages sharing a contract), put a warning comment on BOTH sides naming the
  counterpart file.
- Verbose multi-paragraph dartdoc where one line suffices is an anti-pattern.
