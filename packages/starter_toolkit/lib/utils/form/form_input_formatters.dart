import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Reusable [TextInputFormatter]s for common form fields.
class FormInputFormatters {
  /// Phone mask without country code: `(###) ###-##-##`.
  static final phoneShortMask = MaskTextInputFormatter(mask: '(###) ###-##-##');

  /// Phone mask with `+7` country code: `+7 (###) ###-##-##`.
  static final phoneLongMask = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
  );

  /// Length limit matching the longest formatted phone (18 chars).
  static final phoneMaxLength = LengthLimitingTextInputFormatter(18);

  /// Builds a formatter for a dynamic mask (e.g. from remote config),
  /// where `#` marks a digit slot: `(###) ###-###`.
  static TextInputFormatter phoneMask(String mask) =>
      MaskTextInputFormatter(mask: mask);
}
