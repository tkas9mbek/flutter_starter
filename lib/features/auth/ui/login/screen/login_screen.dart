import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/focus_on_invalid_field.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  void onSubmitted(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final form = LoginForm.fromForm(
        formKey.currentState!.value,
      );
      context.read<LoginBloc>().add(LoginEvent.submitted(form));
    } else {
      focusOnInvalidStateField(formKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final theme = ThemeProvider.of(context).theme;

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(getIt<AuthRepository>()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) => state.mapOrNull(
          failure: (state) => NotificationSnackBar.showExceptionMessage(
            context,
            exception: state.exception,
          ),
        ),
        builder: (context, state) => FormBuilder(
          key: formKey,
          child: Scaffold(
            appBar: TitleAppBar(title: Localizer.of(context).login),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            AppTextField(
                              name: LoginForm.phoneField,
                              label: Localizer.of(context).phoneNumber,
                              hint: Localizer.of(context).enterPhoneNumber,
                              keyboardType: TextInputType.phone,
                              required: true,
                              validators: [
                                FormValidators.phone(context),
                              ],
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              name: LoginForm.passwordField,
                              label: Localizer.of(context).password,
                              hint: Localizer.of(context).enterPassword,
                              keyboardType: TextInputType.visiblePassword,
                              required: true,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () =>
                            context.router.push(const RegistrationRoute()),
                        child: Text(
                          Localizer.of(context).haveNoAccount,
                          style: textStyles.boldBody13.copyWith(
                            color: theme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppElevatedButton.big(
                        context: context,
                        loading: state.isLoading,
                        text: Localizer.of(context).toLogin,
                        onPressed: () => onSubmitted(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
