/// Annotation to configure exception UI mapping generation.
///
/// Used by code generator to create ExceptionUiMapper methods automatically.
class ExceptionUiConfig {
  /// Localization key for title (optional)
  final String? titleKey;

  /// Localization key for description (required)
  final String descriptionKey;

  /// Localization key for snackbar (defaults to descriptionKey)
  final String? snackbarKey;

  /// Whether automatic retry should be allowed
  final bool canRetry;

  /// Whether refresh button should be shown in UI
  final bool canRefresh;

  const ExceptionUiConfig({
    this.titleKey,
    required this.descriptionKey,
    this.snackbarKey,
    this.canRetry = true,
    this.canRefresh = true,
  });
}
