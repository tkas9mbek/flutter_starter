import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:starter/features/auth/ui/otp/widget/otp_body.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/form/otp_code_field.dart';

/// Confirms the one-time code sent to [phone]. On success the
/// AuthRepository flips to authenticated and [GlobalRouteWrapper]
/// navigates away.
@RoutePage()
class OtpScreen extends StatelessWidget {
  const OtpScreen({required this.phone, super.key});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpBloc>(
      create: (context) =>
          getIt<OtpBloc>()..add(OtpEvent.resent(phone: phone)),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.phone});

  final String phone;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  static const _countdownStart = 30;

  final _fieldController = OtpCodeFieldController();

  String _code = '';
  String? _error;
  int _secondsLeft = _countdownStart;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _countdownStart);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();

        return;
      }

      setState(() => _secondsLeft--);
    });
  }

  void _onCompleted(String code) {
    _code = code;
    _submit();
  }

  void _submit() {
    if (_code.isEmpty) {
      return;
    }

    context.read<OtpBloc>().add(
      OtpEvent.submitted(phone: widget.phone, otp: _code),
    );
  }

  void _onResend() {
    if (_secondsLeft > 0) {
      return;
    }

    _fieldController.clear();
    setState(() {
      _code = '';
      _error = null;
    });
    _startCountdown();
    context.read<OtpBloc>().add(OtpEvent.resent(phone: widget.phone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is FailureOtpState) {
          setState(() => _error = Localizer.of(context).otpInvalid);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ThemeProvider.of(context).theme.background,
        appBar: const TitleAppBar(title: ''),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: OtpBody(
            destination: widget.phone,
            fieldController: _fieldController,
            error: _error,
            secondsLeft: _secondsLeft,
            onCompleted: _onCompleted,
            onResend: _onResend,
            onSubmit: _submit,
          ),
        ),
      ),
    );
  }
}
