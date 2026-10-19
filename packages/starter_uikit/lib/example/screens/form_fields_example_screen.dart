import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_toolkit/utils/form/validatable_text_editing_controller.dart';
import 'package:starter_uikit/example/widgets/example_section.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_field.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_group.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';
import 'package:starter_uikit/widgets/form/app_radio_group.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/app_time_picker_field.dart';
import 'package:starter_uikit/widgets/form/controller_text_field.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';
import 'package:starter_uikit/widgets/form/country/country_code_field.dart';
import 'package:starter_uikit/widgets/form/otp_code_field.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

const _options = ['option1', 'option2', 'option3'];

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class FormFieldsExampleScreen extends StatefulWidget {
  const FormFieldsExampleScreen({super.key});

  @override
  State<FormFieldsExampleScreen> createState() =>
      _FormFieldsExampleScreenState();
}

class _FormFieldsExampleScreenState extends State<FormFieldsExampleScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.formFields),
      body: FormBuilder(
        key: _formKey,
        initialValue: const {
          'checkbox_disabled': true,
          'checkbox_group_disabled': {'option2'},
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _TextFieldsSection(),
              const _ControllerFieldSection(),
              const _PickerFieldsSection(),
              const _SelectionSection(),
              const _OtpSection(),
              AppElevatedButton.big(
                context: context,
                text: 'Validate form',
                onPressed: () => _formKey.currentState?.saveAndValidate(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _optionLabel(BuildContext context, String value) {
  final localizer = UikitLocalizer.of(context);

  return switch (value) {
    'option1' => localizer.option1,
    'option2' => localizer.option2,
    'option3' => localizer.option3,
    _ => value,
  };
}

class _TextFieldsSection extends StatelessWidget {
  const _TextFieldsSection();

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return ExampleSection(
      title: localizer.textField,
      children: [
        AppTextField(
          name: 'text_field',
          label: localizer.textField,
          hint: localizer.enterText,
          hasClearButton: true,
        ),
        const AppTextField(
          name: 'text_required',
          label: 'Required (validate to see the error state)',
          required: true,
          colorLabelOnError: true,
        ),
        const AppTextField(
          name: 'text_password',
          label: 'Password',
          canObscureText: true,
        ),
        const AppTextField(
          name: 'text_counter',
          label: 'With counter',
          maxLength: 40,
        ),
        const AppTextField(
          name: 'text_loading',
          label: 'Loading',
          initialValue: 'Checking…',
          loading: true,
        ),
        const AppTextField(
          name: 'text_disabled',
          label: 'Disabled',
          initialValue: 'Read only value',
          enabled: false,
        ),
        const _PhoneField(),
      ],
    );
  }
}

class _PhoneField extends StatefulWidget {
  const _PhoneField();

  @override
  State<_PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<_PhoneField> {
  static const _countries = [
    CountryCode(name: 'Kyrgyzstan', dialCode: '+996', flag: '🇰🇬'),
    CountryCode(name: 'Kazakhstan', dialCode: '+7', flag: '🇰🇿'),
    CountryCode(name: 'Uzbekistan', dialCode: '+998', flag: '🇺🇿'),
  ];

  var _country = _countries.first;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      name: 'text_phone',
      hint: 'Phone number',
      keyboardType: TextInputType.phone,
      prefixWidget: CountryCodeField(
        countries: _countries,
        selected: _country,
        onChanged: (country) => setState(() => _country = country),
      ),
    );
  }
}

class _ControllerFieldSection extends StatefulWidget {
  const _ControllerFieldSection();

  @override
  State<_ControllerFieldSection> createState() =>
      _ControllerFieldSectionState();
}

class _ControllerFieldSectionState extends State<_ControllerFieldSection> {
  final _controller = ValidatableTextEditingController(
    validators: [
      (value) => (value?.length ?? 0) < 3 ? 'Type at least 3 characters' : null,
    ],
  );

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return ExampleSection(
      title: 'Controller text field',
      children: [
        ControllerTextField<ValidatableTextEditingController>(
          controller: _controller,
          hint: 'Search (submit to validate)',
          hasClearButton: true,
          textInputAction: TextInputAction.search,
          validate: (controller) => controller.error,
          onSubmitted: (_) => _controller.validate(),
          suffix: SvgIcon(
            UiSvgIcons.searchGlyph,
            size: 20,
            color: theme.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _PickerFieldsSection extends StatelessWidget {
  const _PickerFieldsSection();

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return ExampleSection(
      title: '${localizer.dropdownField} / ${localizer.datePickerField}',
      children: [
        AppDropdownField<String>(
          name: 'dropdown_field',
          label: localizer.dropdownField,
          hint: localizer.selectOption,
          options: _options,
          required: true,
          optionLabelBuilder: (value) => _optionLabel(context, value),
        ),
        AppDropdownField<String>(
          name: 'dropdown_disabled',
          label: 'Disabled',
          options: _options,
          initialValue: _options.first,
          enabled: false,
          optionLabelBuilder: (value) => _optionLabel(context, value),
        ),
        AppDatePickerField(
          name: 'date_field',
          label: localizer.datePickerField,
          minDate: DateTime(1900),
          maxDate: DateTime.now(),
        ),
        const AppTimePickerField(name: 'time_field', label: 'Time'),
      ],
    );
  }
}

class _SelectionSection extends StatelessWidget {
  const _SelectionSection();

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return ExampleSection(
      title: localizer.checkboxField,
      children: [
        AppCheckboxField(
          name: 'checkbox_field',
          label: localizer.agreeToTerms,
          hideErrorText: false,
          validator: (value) => value == true ? null : 'Required',
        ),
        const AppCheckboxField(
          name: 'checkbox_disabled',
          label: 'Disabled, checked',
          enabled: false,
        ),
        AppCheckboxGroup<String>(
          name: 'checkbox_group',
          options: _options.toSet(),
          optionLabelBuilder: (value) => _optionLabel(context, value),
        ),
        AppCheckboxGroup<String>(
          name: 'checkbox_group_disabled',
          options: _options.toSet(),
          enabled: false,
          optionLabelBuilder: (value) => _optionLabel(context, value),
        ),
        AppRadioGroup<String>(
          name: 'radio_group',
          options: _options,
          selected: _options.first,
          optionLabelBuilder: (value) => _optionLabel(context, value),
        ),
      ],
    );
  }
}

class _OtpSection extends StatelessWidget {
  const _OtpSection();

  @override
  Widget build(BuildContext context) {
    return ExampleSection(
      title: 'OTP code',
      children: [
        OtpCodeField(onCompleted: (_) {}),
        OtpCodeField(hasError: true, onCompleted: (_) {}),
      ],
    );
  }
}
