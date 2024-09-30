import 'package:flutter/material.dart';
import 'package:flutter_starter/generated/l10n.dart';

class FormValidators {
  static FormFieldValidator<T> required<T>(
    BuildContext context, {
    String? message,
  }) =>
      (value) {
        if (value == null ||
            value.toString().trim().isEmpty ||
            (value is List && value.isEmpty)) {
          return message ?? S.of(context).errorRequiredField;
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
          return message ?? S.of(context).errorInvalidUrlFormat;
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

        if (value.length != 15) {
          return message ?? S.of(context).errorInvalidPhoneFormat;
        }

        return null;
      };
}
