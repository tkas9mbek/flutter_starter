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

  /// Whether retry button should be shown
  final bool canRefresh;

  /// Whether automatic retry should be attempted
  final bool canRetry;

  const ExceptionUiModel({
    this.title,
    required this.description,
    required this.snackbarDescription,
    this.canRefresh = true,
    this.canRetry = true,
  });

  /// Creates UI model for "no retry" scenarios
  const ExceptionUiModel.noRetry({
    String? title,
    required String description,
    String? snackbarDescription,
  }) : this(
          title: title,
          description: description,
          snackbarDescription: snackbarDescription ?? description,
          canRefresh: false,
          canRetry: false,
        );

  /// Creates UI model with all defaults
  const ExceptionUiModel.simple({
    required String description,
  }) : this(
          title: null,
          description: description,
          snackbarDescription: description,
          canRefresh: true,
          canRetry: true,
        );

  @override
  List<Object?> get props => [
        title,
        description,
        snackbarDescription,
        canRefresh,
        canRetry,
      ];

  @override
  String toString() => 'ExceptionUiModel('
      'title: $title, '
      'description: $description, '
      'snackbarDescription: $snackbarDescription, '
      'canRefresh: $canRefresh, '
      'canRetry: $canRetry)';
}
