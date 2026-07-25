# Product Context for AI Agents

> **Template**: Fill this in when starting a new app from the starter. Keep it a durable,
> compact snapshot agents can trust. Add a source-snapshot date and Figma file key at the top.

<!-- Source snapshot: YYYY-MM-DD. Built from Figma file `<file-key>` and the current code. -->

## Product

<!-- 2-4 sentences: what the app is, who it is for, and what surface is actually
     designed/implemented vs. planned. Be explicit about what the app is NOT. -->

Primary user jobs:

<!-- 4-6 bullets, each a concrete job-to-be-done.
     Example: "Track daily tasks on a calendar and mark them complete." -->

<!-- State the product's primary copy language and supported locales.
     The starter uses intl_utils with `en` as main locale; all user-facing strings
     must go through `Localizer.of(context)`. -->

## Figma Inventory

<!-- Figma URL and main page name. Then a table of top-level sections so agents can
     locate frames without scanning the whole file. -->

| Section | Frames | Product meaning |
| --- | ---: | --- |
| <!-- e.g. `Auth` --> | <!-- 5 --> | <!-- Login, registration, success states --> |

<!-- Note the target device frame size (e.g. 390x844), theme (light/dark), and shell
     shape (e.g. bottom tab bar with N tabs). -->

## Information Architecture

Initial/auth stack:

<!-- Bullets: onboarding, login/registration shape, any first-run setup flow.
     The starter ships email/password login and registration screens. -->

Authenticated shell:

<!-- One bullet per tab. The starter's root shell has: Calendar, Tasks, Settings, Profile. -->

Full-screen flows above the shell:

<!-- Detail screens, editors, modals pushed over the shell.
     Example: task details opened from the calendar or list. -->

## Domain Vocabulary

Use these domain words consistently in models, states, and UI:

<!-- Grouped noun list your team commits to. Starter baseline: User, AuthToken, Task,
     Settings (language/theme). Extend per product; avoid synonyms for the same concept. -->

<!-- Optionally note the design's sample data (names, currencies, IDs) so agents keep
     mock data consistent with Figma. -->

## Backend Reality

<!-- Which features are API-backed today vs. mock/local. The starter's feature modules
     switch data sources via `useMock`; list what is safe to treat as real. -->

Treat these as local/mock or partial until backend contracts are confirmed:

<!-- Bullet list of unconfirmed surfaces. -->

## Product Constraints for Agents

<!-- Hard rules that prevent scope drift. Examples:
     - This is a customer app, not an admin app.
     - Preserve the tab shell; do not add tabs without product direction.
     - When backend support is missing, use mock behavior intentionally. -->
