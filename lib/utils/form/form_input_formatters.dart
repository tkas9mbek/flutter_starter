import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormInputFormatters {
  static final phoneShortMask = MaskTextInputFormatter(mask: '(###) ###-##-##');

  static final phoneLongMask =
      MaskTextInputFormatter(mask: '+7 (###) ###-##-##');
}
