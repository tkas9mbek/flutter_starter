import 'package:equatable/equatable.dart';

/// UI model for displaying exceptions.
///
/// Contains all information needed for UI presentation:
/// - Localized messages
/// - Display flags
/// - Action availability
class ExceptionUiModel extends Equatable {
  /// Optional title for dialogs/large error views
  final String? title;

  /// Main error description
  final String description;

  /// Brief description for snackbars (may differ from main)
  final String snackbarDescription;

  /// Whether retry/refresh actions should be shown
  /// Controls both manual refresh button and automatic retry
  final bool canRetry;

  const ExceptionUiModel({
    required this.description,
    required this.snackbarDescription,
    this.title,
    this.canRetry = true,
  });

  /// Creates UI model for "no retry" scenarios
  const ExceptionUiModel.noRetry({
    required String description,
    String? title,
    String? snackbarDescription,
  }) : this(
          title: title,
          description: description,
          snackbarDescription: snackbarDescription ?? description,
          canRetry: false,
        );

  /// Creates UI model with all defaults
  const ExceptionUiModel.simple({
    required String description,
    bool canRetry = true,
  }) : this(
          title: null,
          description: description,
          snackbarDescription: description,
          canRetry: canRetry,
        );

  @override
  List<Object?> get props => [
        title,
        description,
        snackbarDescription,
        canRetry,
      ];

  @override
  String toString() => 'ExceptionUiModel('
      'title: $title, '
      'description: $description, '
      'snackbarDescription: $snackbarDescription, '
      'canRetry: $canRetry)';
}
