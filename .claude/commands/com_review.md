---
description: Review branch vs main per docs/ai-context/code_review.md and save the report to work/review.md. For a neutral branch summary use /com_read_branch.
---

Delegate to the reviewer agent: review all changes in this branch vs main and write
`work/review.md` following `docs/ai-context/code_review.md` EXACTLY — its severity
levels (🔴 Blocking / 🟡 Format / 🟢 Suggestion), rule IDs (ARCH/BLOC/EXC/UI/NAME/FILE/
TEST/STYLE), table format with (N) code blocks below tables, "No issues found." for
clean sections, counts per severity, and the Verdict line. Skip rules tagged `[lint]` —
those are auto-enforced by `starter_lints` / the analyzer, not manual review.

The reviewer must first read `docs/ai-context/code_review.md`, `rules.md`,
`architecture.md`, `bloc.md`, and `exception.md`, then analyze each changed file
against all rule groups.

In this conversation return only: the path, counts per severity, the Verdict, and any
🔴 Blocking findings verbatim.
