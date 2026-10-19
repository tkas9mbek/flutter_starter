import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_visual_state.dart';

void main() {
  group('TextFieldVisualState.resolve', () {
    const cases = [
      // (enabled, focused, hasError) -> state
      (true, false, false, TextFieldVisualState.idle),
      (true, true, false, TextFieldVisualState.focused),
      (true, false, true, TextFieldVisualState.error),
      (true, true, true, TextFieldVisualState.error),
      (false, false, false, TextFieldVisualState.disabled),
      (false, true, true, TextFieldVisualState.disabled),
    ];

    for (final (enabled, focused, hasError, expected) in cases) {
      test('enabled=$enabled focused=$focused hasError=$hasError', () {
        final state = TextFieldVisualState.resolve(
          enabled: enabled,
          focused: focused,
          hasError: hasError,
        );

        expect(state, expected);
      });
    }
  });

  group('TextFieldVisualState colors', () {
    final theme = AppTheme.light();

    test('outline is border at rest, accent focused, errorText invalid', () {
      expect(TextFieldVisualState.idle.borderColor(theme), theme.border);
      expect(TextFieldVisualState.focused.borderColor(theme), theme.accent);
      expect(TextFieldVisualState.error.borderColor(theme), theme.errorText);
      expect(TextFieldVisualState.disabled.borderColor(theme), theme.border);
    });

    test('custom fill applies only while enabled', () {
      final fill = theme.selectedSurface;

      expect(TextFieldVisualState.idle.fillColor(theme, fill: fill), fill);
      expect(TextFieldVisualState.idle.fillColor(theme), theme.surface);
      expect(
        TextFieldVisualState.disabled.fillColor(theme, fill: fill),
        theme.surfaceMuted,
      );
    });

    test('error label color can be suppressed', () {
      expect(TextFieldVisualState.error.labelColor(theme), theme.errorText);
      expect(
        TextFieldVisualState.error.labelColor(theme, colorError: false),
        theme.textSecondary,
      );
    });
  });
}
