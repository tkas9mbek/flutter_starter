import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/form_input_formatters.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

class RegistrationFormFields extends StatelessWidget {
  const RegistrationFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          name: RegistrationForm.nameField,
          label: Localizer.of(context).name,
          hint: Localizer.of(context).enterYourName,
          keyboardType: TextInputType.name,
          required: true,
        ),
        const SizedBox(height: 20),
        AppDatePickerField(
          name: RegistrationForm.birthdayField,
          label: Localizer.of(context).birthday,
          hint: Localizer.of(context).selectYourBirthday,
          minDate: DateTime(1900),
          maxDate: DateTime.now(),
          required: true,
        ),
        const SizedBox(height: 20),
        AppTextField(
          name: RegistrationForm.phoneField,
          label: Localizer.of(context).phoneNumber,
          hint: Localizer.of(context).enterPhoneNumber,
          keyboardType: TextInputType.phone,
          inputFormatters: [FormInputFormatters.phoneMaxLength],
          required: true,
          validators: [FormValidators.phone(context)],
        ),
        const SizedBox(height: 20),
        AppTextField(
          name: RegistrationForm.passwordField,
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
