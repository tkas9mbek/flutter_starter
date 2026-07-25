import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/dev_mode_activator.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter/features/auth/ui/register/widget/registration_body.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/save_and_validate_form.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  void onSubmitted(BuildContext context) {
    if (saveAndValidateForm(formKey)) {
      final form = RegistrationForm.fromForm(formKey.currentState!.value);
      context.read<RegistrationBloc>().add(RegistrationEvent.submitted(form));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (context) => getIt<RegistrationBloc>(),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => FormBuilder(
          key: formKey,
          child: DevModeActivator(
            child: Scaffold(
              appBar: TitleAppBar(title: Localizer.of(context).login),
              body: RegistrationBody(
                onLoginTap: () => context.router.replace(const LoginRoute()),
                onRegisterPressed: () => onSubmitted(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
