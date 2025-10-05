import 'package:flutter/material.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class FormValidators {
  static FormFieldValidator<T> required<T>(
    BuildContext context, {
    String? message,
  }) =>
      (value) {
        if (value == null ||
            value.toString().trim().isEmpty ||
            (value is List && value.isEmpty)) {
          return message ?? ToolkitLocalizer.of(context).errorRequiredField;
        }

        return null;
      };

  static FormFieldValidator<T> url<T>(
    BuildContext context, {
    String? message,
  }) =>
      (value) {
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

  static FormFieldValidator<String> phone(
    BuildContext context, {
    String? message,
  }) =>
      (value) {
        if (value == null || value.trim().isEmpty) {
          return null;
        }

        if (value.length < 10 || value.length > 16) {
          return message ?? ToolkitLocalizer.of(context).errorInvalidPhoneFormat;
        }

        return null;
      };
}
