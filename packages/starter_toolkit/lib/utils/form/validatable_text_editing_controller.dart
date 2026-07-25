import 'package:flutter/widgets.dart';

/// [TextEditingController] that carries its own validation rules and error.
///
/// Pass rules via [validators], then call [validate] from a submit action.
/// Validation runs only when [validate] is called; on an [error] change the
/// controller notifies its listeners, so a field reading
/// `validate: (c) => c.error` repaints automatically.
class ValidatableTextEditingController extends TextEditingController {
  ValidatableTextEditingController({this.validators = const [], super.text});

  /// Validates every controller, surfacing each field's error, and returns
  /// whether all are valid.
  static bool validateAll(List<ValidatableTextEditingController> controllers) {
    var isValid = true;

    for (final controller in controllers) {
      if (!controller.validate()) {
        isValid = false;
      }
    }

    return isValid;
  }

  /// Validation functions. First non-null result becomes the [error].
  final List<String? Function(String?)> validators;

  String? _error;

  /// Current validation error, or null when valid / not yet validated.
  String? get error => _error;

  /// Runs [validators] in order, publishes the first error to [error], and
  /// returns whether the field is valid.
  bool validate() {
    String? result;

    for (final validator in validators) {
      result = validator(text);

      if (result != null) {
        break;
      }
    }

    _setError(result);

    return result == null;
  }

  /// Clears the current error without running [validators].
  void resetValidation() => _setError(null);

  void _setError(String? error) {
    if (_error == error) {
      return;
    }

    _error = error;
    notifyListeners();
  }
}
