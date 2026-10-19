import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_visual_state.dart';

/// Clears an [OtpCodeField] from outside (e.g. on resend).
class OtpCodeFieldController {
  _OtpCodeFieldState? _state;

  void clear() => _state?.clearDigits();
}

/// Row of [length] single-digit boxes for entering a one-time code; focus
/// advances on input and retreats on deletion, and [onCompleted] fires once
/// every digit is filled. Clearable externally via [OtpCodeFieldController].
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    required this.onCompleted,
    this.length = 4,
    this.hasError = false,
    this.controller,
    super.key,
  });

  final int length;
  final bool hasError;
  final OtpCodeFieldController? controller;
  final ValueChanged<String> onCompleted;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  late final _controllers = List.generate(
    widget.length,
    (_) => TextEditingController(),
  );
  late final _focusNodes = List.generate(widget.length, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;
  }

  @override
  void didUpdateWidget(OtpCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._state = null;
      widget.controller?._state = this;
    }
  }

  @override
  void dispose() {
    widget.controller?._state = null;
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void clearDigits() {
    for (final controller in _controllers) {
      controller.clear();
    }
    _focusNodes.first.requestFocus();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }

      return;
    }

    final code = _controllers.map((controller) => controller.text).join();

    if (code.length == widget.length) {
      FocusScope.of(context).unfocus();
      widget.onCompleted(code);

      return;
    }

    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final radius = BorderRadius.circular(AppRadii.control);

    OutlineInputBorder outline({required bool focused}) => OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: TextFieldVisualState.resolve(
          enabled: true,
          focused: focused,
          hasError: widget.hasError,
        ).borderColor(theme),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.length; i++) ...[
          SizedBox(
            width: 48,
            height: 52,
            child: TextField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: textStyles.mediumTitle24,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: theme.surface,
                border: outline(focused: false),
                enabledBorder: outline(focused: false),
                focusedBorder: outline(focused: true),
              ),
              onChanged: (value) => _onDigitChanged(i, value),
            ),
          ),
        ],
      ],
    );
  }
}
