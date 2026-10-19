import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/app_theme.dart';

void main() {
  final modes = {
    Brightness.light: AppTheme.light(),
    Brightness.dark: AppTheme.dark(),
  };

  modes.forEach(
    (brightness, theme) => group('themeDataFromTheme (${brightness.name})', () {
      final data = theme.toThemeData();
      const noStates = <WidgetState>{};

      test('the app bar and scaffold share the theme background', () {
        expect(data.scaffoldBackgroundColor, theme.background);
        expect(data.appBarTheme.backgroundColor, theme.background);
      });

      test('has no elevation on any surface', () {
        expect(data.appBarTheme.elevation, 0);
        expect(data.appBarTheme.scrolledUnderElevation, 0);
        expect(data.cardTheme.elevation, 0);
        expect(data.dialogTheme.elevation, 0);
        expect(data.bottomSheetTheme.elevation, 0);
        expect(data.bottomSheetTheme.modalElevation, 0);
        expect(data.snackBarTheme.elevation, 0);
        expect(data.elevatedButtonTheme.style!.elevation!.resolve(noStates), 0);
      });

      test('has no shadows, surface tint or splash', () {
        expect(data.cardTheme.shadowColor, AppColors.transparent);
        expect(
          data.elevatedButtonTheme.style!.shadowColor!.resolve(noStates),
          AppColors.transparent,
        );
        expect(data.appBarTheme.surfaceTintColor, AppColors.transparent);
        expect(data.cardTheme.surfaceTintColor, AppColors.transparent);
        expect(data.dialogTheme.surfaceTintColor, AppColors.transparent);
        expect(data.bottomSheetTheme.surfaceTintColor, AppColors.transparent);
        expect(data.splashFactory, NoSplash.splashFactory);
        expect(data.splashColor, AppColors.transparent);
        expect(data.highlightColor, AppColors.transparent);
      });

      test('uses Material 2 and the brightness of the mode', () {
        expect(data.useMaterial3, isFalse);
        expect(data.brightness, brightness);
        expect(data.colorScheme.brightness, brightness);
      });

      test('button shapes use the control radius', () {
        final controlShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
        );

        for (final style in [
          data.elevatedButtonTheme.style!,
          data.outlinedButtonTheme.style!,
          data.textButtonTheme.style!,
        ]) {
          expect(style.shape!.resolve(noStates), controlShape);
          expect(style.splashFactory, NoSplash.splashFactory);
        }
      });

      test('the color scheme maps the theme roles', () {
        final scheme = data.colorScheme;

        expect(scheme.primary, theme.primary);
        expect(scheme.onPrimary, theme.onPrimary);
        expect(scheme.secondary, theme.secondary);
        expect(scheme.onSecondary, theme.onSecondary);
        expect(scheme.surface, theme.surface);
        expect(scheme.onSurface, theme.textPrimary);
        expect(scheme.error, theme.error);
        expect(scheme.onError, theme.onStatus);
      });

      test('the elevated button swaps to muted colors when disabled', () {
        final style = data.elevatedButtonTheme.style!;
        const disabled = {WidgetState.disabled};

        expect(style.backgroundColor!.resolve(noStates), theme.primary);
        expect(style.foregroundColor!.resolve(noStates), theme.onPrimary);
        expect(style.backgroundColor!.resolve(disabled), theme.surfaceMuted);
        expect(style.foregroundColor!.resolve(disabled), theme.textTertiary);
      });
    }),
  );
}
