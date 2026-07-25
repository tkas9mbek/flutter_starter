import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/form_input_formatters.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          name: LoginForm.phoneField,
          label: Localizer.of(context).phoneNumber,
          hint: Localizer.of(context).enterPhoneNumber,
          keyboardType: TextInputType.phone,
          inputFormatters: [FormInputFormatters.phoneMaxLength],
          required: true,
          validators: [FormValidators.phone(context)],
        ),
        const SizedBox(height: 20),
        AppTextField(
          name: LoginForm.passwordField,
          label: Localizer.of(context).password,
          hint: Localizer.of(context).enterPassword,
          keyboardType: TextInputType.visiblePassword,
          canObscureText: true,
          required: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
