import 'package:flutter/material.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

/// Reusable [FormFieldValidator]s with localized default messages.
class FormValidators {
  /// Returns a validator that fails when the value is null, empty, or a
  /// blank string. Empty lists are also rejected.
  static FormFieldValidator<T> required<T>(
    BuildContext context, {
    String? message,
  }) => (value) {
    if (value == null ||
        value.toString().trim().isEmpty ||
        (value is List && value.isEmpty)) {
      return message ?? ToolkitLocalizer.of(context).errorRequiredField;
    }

    return null;
  };

  /// Returns a validator that fails when the value is non-empty and does
  /// not match an `http(s)://` URL pattern. Empty values pass — combine
  /// with [required] to forbid them.
  static FormFieldValidator<T> url<T>(
    BuildContext context, {
    String? message,
  }) => (value) {
    if (value == null || value.toString().trim().isEmpty) {
      return null;
    }

    final urlPattern = RegExp(
      r'^(http|https):\/\/[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+([/?].*)?$',
      caseSensitive: false,
    );

    if (!urlPattern.hasMatch(value.toString())) {
      return message ?? ToolkitLocalizer.of(context).errorInvalidUrlFormat;
    }

    return null;
  };

  /// Returns a validator that fails when the value's length is outside
  /// the 10–16 character range. Empty values pass — combine with
  /// [required] to forbid them.
  static FormFieldValidator<String> phone(
    BuildContext context, {
    String? message,
  }) => (value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.length < 10 || value.length > 16) {
      return message ?? ToolkitLocalizer.of(context).errorInvalidPhoneFormat;
    }

    return null;
  };
}
