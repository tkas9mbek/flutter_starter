/// Annotation to configure exception UI mapping generation.
///
/// Used by code generator to create ExceptionUiMapper methods automatically.
/// The `canRetry` field is read from the exception class itself.
class ExceptionUiConfig {
  /// Localization key for title (optional)
  final String? titleKey;

  /// Localization key for description (required)
  final String descriptionKey;

  /// Localization key for snackbar (defaults to descriptionKey)
  final String? snackbarKey;

  const ExceptionUiConfig({
    required this.descriptionKey,
    this.titleKey,
    this.snackbarKey,
  });
}
