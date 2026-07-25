/// Configures generation of `ExceptionUiMapper` methods for an annotated [AppException].
///
/// Read by `starter_uikit/utils/generators/generate_exception_mapper.dart`, whose output
/// is `starter_uikit/lib/utils/mappers/exception_ui_mapper.dart` — rerun the generator after
/// changing these keys. `canRetry` comes from the exception class, not this annotation.
class ExceptionUiConfig {
  const ExceptionUiConfig({
    required this.descriptionKey,
    this.titleKey,
    this.snackbarKey,
  });

  /// Localization key for the title.
  final String? titleKey;

  /// Localization key for the description.
  final String descriptionKey;

  /// Localization key for the snackbar; falls back to [descriptionKey] when null.
  final String? snackbarKey;
}
