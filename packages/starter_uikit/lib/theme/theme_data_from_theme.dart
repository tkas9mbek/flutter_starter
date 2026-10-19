import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Projects an [AppTheme] onto Material's [ThemeData], for the widgets the uikit does not own.
///
/// Flat design: no elevation, shadow, ripple or surface tint anywhere, and
/// every outline is a 1px border. Input borders are stripped because uikit
/// form fields draw their own container and error state.
ThemeData themeDataFromTheme({
  required AppTheme theme,
  required AppTextStyles textStyles,
}) {
  const noBorder = InputBorder.none;
  const noOverlay = WidgetStatePropertyAll<Color>(AppColors.transparent);

  final isDark = theme.themeMode == ThemeMode.dark;
  final brightness = isDark ? Brightness.dark : Brightness.light;
  final controlShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadii.control),
  );
  final hairline = BorderSide(color: theme.border);

  return ThemeData(
    fontFamily: textStyles.fontFamily,
    scaffoldBackgroundColor: theme.background,
    useMaterial3: false,
    brightness: brightness,
    primaryColor: theme.primary,
    canvasColor: theme.surface,
    cardColor: theme.surface,
    dividerColor: theme.border,
    disabledColor: theme.textPlaceholder,
    hintColor: theme.textPlaceholder,
    unselectedWidgetColor: theme.textTertiary,
    colorScheme: ColorScheme(
      primary: theme.primary,
      secondary: theme.secondary,
      surface: theme.surface,
      error: theme.error,
      onPrimary: theme.onPrimary,
      onSecondary: theme.onSecondary,
      onSurface: theme.textPrimary,
      onError: theme.onStatus,
      outline: theme.border,
      outlineVariant: theme.borderStrong,
      brightness: brightness,
    ),
    textTheme: TextTheme(
      headlineMedium: textStyles.boldTitle28,
      headlineSmall: textStyles.boldTitle24,
      titleLarge: textStyles.boldTitle20,
      titleMedium: textStyles.regularTitle20,
      titleSmall: textStyles.regularTitle18,
      bodyLarge: textStyles.regularBody16,
      bodyMedium: textStyles.regularBody14,
      bodySmall: textStyles.regularBody13,
      labelLarge: textStyles.mediumBody16,
      labelMedium: textStyles.mediumBody14,
      labelSmall: textStyles.mediumBody12,
    ),
    iconTheme: IconThemeData(color: theme.textPrimary),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: theme.accent,
      selectionColor: theme.primary.withValues(alpha: 0.24),
      selectionHandleColor: theme.accent,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: theme.accent,
      linearTrackColor: theme.surfaceMuted,
      circularTrackColor: AppColors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: noBorder,
      enabledBorder: noBorder,
      focusedBorder: noBorder,
      errorBorder: noBorder,
      focusedErrorBorder: noBorder,
      disabledBorder: noBorder,
      contentPadding: EdgeInsets.zero,
      hintStyle: textStyles.regularBody14.copyWith(
        color: theme.textPlaceholder,
      ),
      labelStyle: textStyles.regularBody14.copyWith(color: theme.textSecondary),
      helperStyle: textStyles.regularBody12.copyWith(color: theme.textTertiary),
      errorStyle: textStyles.regularBody12.copyWith(color: theme.errorText),
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: AppColors.transparent,
    splashColor: AppColors.transparent,
    // The app bar is the same color as the scaffold, so the screen reads as
    // one flat plane that only scrolls beneath it.
    appBarTheme: AppBarTheme(
      backgroundColor: theme.background,
      surfaceTintColor: AppColors.transparent,
      foregroundColor: theme.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: textStyles.mediumTitle20,
      iconTheme: IconThemeData(color: theme.textPrimary),
      actionsIconTheme: IconThemeData(color: theme.textPrimary),
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    ),
    // Keeps the implicit `BackButton` of every pushed screen but swaps Material's glyph for the SVG set's.
    actionIconTheme: const ActionIconThemeData(
      backButtonIconBuilder: _chevronBackButtonIcon,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? theme.surfaceMuted
              : theme.primary,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? theme.textTertiary
              : theme.onPrimary,
        ),
        overlayColor: noOverlay,
        elevation: const WidgetStatePropertyAll(0),
        shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
        textStyle: WidgetStatePropertyAll(textStyles.mediumBody16),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStatePropertyAll(controlShape),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? theme.textTertiary
              : theme.accent,
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => BorderSide(
            color: states.contains(WidgetState.disabled)
                ? theme.border
                : theme.accent,
          ),
        ),
        overlayColor: noOverlay,
        textStyle: WidgetStatePropertyAll(textStyles.mediumBody16),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStatePropertyAll(controlShape),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? theme.textTertiary
              : theme.accent,
        ),
        overlayColor: noOverlay,
        textStyle: WidgetStatePropertyAll(textStyles.mediumBody16),
        shape: WidgetStatePropertyAll(controlShape),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(theme.textPrimary),
        overlayColor: noOverlay,
      ),
    ),
    cardTheme: CardThemeData(
      color: theme.surface,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: hairline,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: theme.textSecondary,
      textColor: theme.textPrimary,
      selectedColor: theme.accent,
      selectedTileColor: theme.selectedSurface,
      titleTextStyle: textStyles.regularBody16,
      subtitleTextStyle: textStyles.regularBody13.copyWith(
        color: theme.textSecondary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: theme.surface,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: hairline,
      ),
      titleTextStyle: textStyles.boldTitle20,
      contentTextStyle: textStyles.regularBody14.copyWith(
        color: theme.textSecondary,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: theme.surface,
      modalBackgroundColor: theme.surface,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      modalElevation: 0,
      dragHandleColor: theme.borderStrong,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
        side: hairline,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: theme.surface,
      actionTextColor: theme.accent,
      contentTextStyle: textStyles.regularBody14,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: BorderSide(color: theme.borderStrong),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(theme.onPrimary),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? theme.primary
            : theme.borderStrong,
      ),
      trackOutlineColor: const WidgetStatePropertyAll(AppColors.transparent),
      overlayColor: noOverlay,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? theme.primary
            : AppColors.transparent,
      ),
      checkColor: WidgetStatePropertyAll(theme.onPrimary),
      side: BorderSide(color: theme.borderStrong, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xs),
      ),
      overlayColor: noOverlay,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? theme.primary
            : theme.borderStrong,
      ),
      overlayColor: noOverlay,
    ),
    dividerTheme: DividerThemeData(color: theme.border, thickness: 1, space: 1),
  );
}

// A top-level tear-off, not a closure, so rebuilt `ThemeData`s stay equal; tinted by the button's `IconTheme`.
Widget _chevronBackButtonIcon(BuildContext context) =>
    SvgIcon(UiSvgIcons.chevronLeft, color: IconTheme.of(context).color);
