import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/focus_on_invalid_field.dart';
import 'package:starter_toolkit/utils/form/form_input_formatters.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  void onSubmitted(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final form = RegistrationForm.fromForm(
        formKey.currentState!.value,
      );
      context.read<RegistrationBloc>().add(RegistrationEvent.submitted(form));
    } else {
      focusOnInvalidStateField(formKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final theme = ThemeProvider.of(context).theme;

    return BlocProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(getIt<AuthRepository>()),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => FormBuilder(
          key: formKey,
          child: Scaffold(
            appBar: TitleAppBar(title: Localizer.of(context).login),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Localizer.of(context).signUp,
                      style: textStyles.boldTitle20,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
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
                              inputFormatters: [
                                FormInputFormatters.phoneMaxLength,
                              ],
                              required: true,
                              validators: [
                                FormValidators.phone(context),
                              ],
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
                        ),
                      ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => context.router.push(const LoginRoute()),
                      child: Text(
                        Localizer.of(context).haveAccount,
                        style: textStyles.boldBody13.copyWith(
                          color: theme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppElevatedButton.big(
                      context: context,
                      text: Localizer.of(context).toRegister,
                      onPressed: () => onSubmitted(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
