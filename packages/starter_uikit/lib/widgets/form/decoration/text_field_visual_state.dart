import 'package:flutter/widgets.dart';
import 'package:starter_uikit/theme/app_theme.dart';

/// Interaction state a text field container paints, shared by every uikit
/// field so idle/focused/error/disabled look the same everywhere.
enum TextFieldVisualState {
  idle,
  focused,
  error,
  disabled;

  /// Disabled outranks error and error outranks focus, so a focused invalid
  /// field still reads as invalid.
  static TextFieldVisualState resolve({
    required bool enabled,
    required bool focused,
    required bool hasError,
  }) => switch ((enabled, hasError, focused)) {
    (false, _, _) => TextFieldVisualState.disabled,
    (_, true, _) => TextFieldVisualState.error,
    (_, _, true) => TextFieldVisualState.focused,
    _ => TextFieldVisualState.idle,
  };

  /// Container fill; [fill] replaces the surface for every enabled state.
  Color fillColor(AppTheme theme, {Color? fill}) => switch (this) {
    TextFieldVisualState.disabled => theme.surfaceMuted,
    _ => fill ?? theme.surface,
  };

  Color borderColor(AppTheme theme) => switch (this) {
    TextFieldVisualState.idle || TextFieldVisualState.disabled => theme.border,
    TextFieldVisualState.focused => theme.accent,
    TextFieldVisualState.error => theme.errorText,
  };

  /// Floating-label color; [colorError] false keeps an invalid field's label
  /// neutral (the border alone signals the error).
  Color labelColor(AppTheme theme, {bool colorError = true}) => switch (this) {
    TextFieldVisualState.focused => theme.accent,
    TextFieldVisualState.error when colorError => theme.errorText,
    TextFieldVisualState.disabled => theme.textTertiary,
    _ => theme.textSecondary,
  };
}
