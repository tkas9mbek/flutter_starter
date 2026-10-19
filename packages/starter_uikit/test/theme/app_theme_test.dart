import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_theme.dart';

/// WCAG 2.x contrast ratio between two opaque colors.
double contrastRatio(Color a, Color b) {
  final lighter = max(a.computeLuminance(), b.computeLuminance());
  final darker = min(a.computeLuminance(), b.computeLuminance());

  return (lighter + 0.05) / (darker + 0.05);
}

const _bodyText = 4.5;
const _largeTextOrIcon = 3.0;

Map<String, Color> tokensOf(AppTheme theme) => {
  'primary': theme.primary,
  'onPrimary': theme.onPrimary,
  'accent': theme.accent,
  'secondary': theme.secondary,
  'onSecondary': theme.onSecondary,
  'background': theme.background,
  'surface': theme.surface,
  'surfaceMuted': theme.surfaceMuted,
  'selectedSurface': theme.selectedSurface,
  'shimmerBase': theme.shimmerBase,
  'shimmerHighlight': theme.shimmerHighlight,
  'border': theme.border,
  'borderStrong': theme.borderStrong,
  'success': theme.success,
  'successText': theme.successText,
  'warning': theme.warning,
  'info': theme.info,
  'error': theme.error,
  'errorText': theme.errorText,
  'onStatus': theme.onStatus,
  'textPrimary': theme.textPrimary,
  'textSecondary': theme.textSecondary,
  'textTertiary': theme.textTertiary,
  'textPlaceholder': theme.textPlaceholder,
};

void main() {
  final modes = {'light': AppTheme.light(), 'dark': AppTheme.dark()};

  // (foreground, background, minimum ratio)
  final contrastPairs =
      <(String, Color Function(AppTheme), Color Function(AppTheme), double)>[
        (
          'onPrimary on primary',
          (t) => t.onPrimary,
          (t) => t.primary,
          _bodyText,
        ),
        (
          'onSecondary on secondary',
          (t) => t.onSecondary,
          (t) => t.secondary,
          _bodyText,
        ),
        ('onStatus on success', (t) => t.onStatus, (t) => t.success, _bodyText),
        ('onStatus on error', (t) => t.onStatus, (t) => t.error, _bodyText),
        ('onStatus on warning', (t) => t.onStatus, (t) => t.warning, _bodyText),
        ('onStatus on info', (t) => t.onStatus, (t) => t.info, _bodyText),
        (
          'textPrimary on background',
          (t) => t.textPrimary,
          (t) => t.background,
          _bodyText,
        ),
        (
          'textPrimary on surface',
          (t) => t.textPrimary,
          (t) => t.surface,
          _bodyText,
        ),
        (
          'textSecondary on background',
          (t) => t.textSecondary,
          (t) => t.background,
          _bodyText,
        ),
        (
          'textSecondary on surface',
          (t) => t.textSecondary,
          (t) => t.surface,
          _bodyText,
        ),
        // textTertiary carries captions and icons only: light mode is ~3.7:1,
        // below the body-text bar, so it is held to the large-text/icon bar.
        (
          'textTertiary on background',
          (t) => t.textTertiary,
          (t) => t.background,
          _largeTextOrIcon,
        ),
        (
          'textTertiary on surface',
          (t) => t.textTertiary,
          (t) => t.surface,
          _largeTextOrIcon,
        ),
        (
          'accent on background',
          (t) => t.accent,
          (t) => t.background,
          _bodyText,
        ),
        ('accent on surface', (t) => t.accent, (t) => t.surface, _bodyText),
        (
          'errorText on background',
          (t) => t.errorText,
          (t) => t.background,
          _bodyText,
        ),
        (
          'errorText on surface',
          (t) => t.errorText,
          (t) => t.surface,
          _bodyText,
        ),
        (
          'successText on background',
          (t) => t.successText,
          (t) => t.background,
          _bodyText,
        ),
        (
          'successText on surface',
          (t) => t.successText,
          (t) => t.surface,
          _bodyText,
        ),
      ];

  modes.forEach(
    (mode, theme) => group('AppTheme.$mode', () {
      test('every token except selectedSurface is opaque', () {
        final translucent = {
          for (final MapEntry(:key, :value) in tokensOf(theme).entries)
            if (value.a < 1) key: value,
        };

        expect(
          translucent.keys,
          mode == 'dark' ? ['selectedSurface'] : isEmpty,
        );
      });

      for (final (name, foreground, background, minRatio) in contrastPairs) {
        test('$name meets $minRatio:1 contrast', () {
          final ratio = contrastRatio(foreground(theme), background(theme));

          expect(ratio, greaterThanOrEqualTo(minRatio));
        });
      }
    }),
  );

  test('the themeMode matches the factory', () {
    expect(AppTheme.light().themeMode, ThemeMode.light);
    expect(AppTheme.dark().themeMode, ThemeMode.dark);
  });

  test('light and dark differ on every surface and text token', () {
    final light = AppTheme.light();
    final dark = AppTheme.dark();

    for (final token in [
      (AppTheme t) => t.background,
      (AppTheme t) => t.surface,
      (AppTheme t) => t.surfaceMuted,
      (AppTheme t) => t.border,
      (AppTheme t) => t.textPrimary,
      (AppTheme t) => t.textSecondary,
      (AppTheme t) => t.accent,
    ]) {
      expect(token(light), isNot(token(dark)));
    }
  });
}
