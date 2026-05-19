# Changelog

All notable changes to starter_lints will be documented in this file.

## [2.1.0] - 2026-05-14

### Added
- Additional lint coverage used by the template’s stricter 2.1 release workflow

### Changed
- Updated package version to align with the main app `2.1.0` release

## [2.0.0] - 2025-02-01

### Added
- Initial release with custom lint rules
- **Available Lints:**
  - `avoid_widget_functions` - Prohibit `_build*` functions returning Widget
  - `prefer_arrow_except_build` - Arrow for callbacks, block for `build()` only
  - `always_spread_in_collections` - Require spread operator in collections
  - `bloc_no_bloc_dependency` - BLoCs cannot inject other BLoCs
  - `blank_line_before_return` - Require blank line before return
  - `sort_constructor_params` - Order: required → defaults → optional → super

### Notes
- Integrated with `custom_lint` plugin in `analysis_options.yaml`
- Works with current freezed version (2.x)
