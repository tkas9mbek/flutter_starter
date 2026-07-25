// ignore_for_file: class_size_warning — mirrors the AppTextField field API surface

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/animated_visibility.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Controller-based text field that does not depend on FormBuilder.
///
/// For FormBuilder forms use `AppTextField`; this widget is for standalone
/// inputs (search, chat, OTP) driven by an external [controller] the parent
/// owns and disposes.
///
/// Validation is owned by the parent, not the field: pass [validate] to derive
/// the message from the typed [controller] — e.g. `validate: (c) => c.error`
/// with a `ValidatableTextEditingController`. The field listens to the
/// controller, so when the error changes the message repaints.
class ControllerTextField<T extends TextEditingController>
    extends StatefulWidget {
  const ControllerTextField({
    required this.controller,
    this.decoration = const FilledTextFieldDecoration(),
    this.maxLines = 1,
    this.minLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.hideErrorText = false,
    this.hasClearButton = false,
    this.loading = false,
    this.canObscureText = false,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.validate,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.textStyle,
    this.maxLength,
    this.color,
    this.focusNode,
    super.key,
  });

  final T controller;

  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  /// Returns the error to display for the current [controller] state, or null
  /// when valid — e.g. `validate: (c) => c.error`.
  final String? Function(T controller)? validate;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final int? maxLines;
  final int? minLines;
  final TextFieldDecoration decoration;
  final Color? color;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle;

  final bool autofocus;
  final bool hideErrorText;
  final bool hasClearButton;
  final bool loading;
  final bool enabled;
  final bool readOnly;
  final bool canObscureText;

  @override
  State<ControllerTextField<T>> createState() => _ControllerTextFieldState<T>();
}

class _ControllerTextFieldState<T extends TextEditingController>
    extends State<ControllerTextField<T>> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();

    obscureText = widget.canObscureText;
    widget.controller.addListener(onControllerChanged);
  }

  @override
  void didUpdateWidget(ControllerTextField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(onControllerChanged);
      widget.controller.addListener(onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(onControllerChanged);

    super.dispose();
  }

  void onControllerChanged() => setState(() {});

  void onCleared() {
    widget.controller.clear();
    widget.onChanged?.call('');
  }

  String? get errorText => widget.validate?.call(widget.controller);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final error = errorText;
    final value = widget.controller.text;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.enabled ? widget.onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.decoration.build(
            context,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    onTap: widget.onTap,
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditingComplete,
                    onSubmitted: widget.onSubmitted,
                    enabled: widget.enabled,
                    readOnly: widget.readOnly,
                    autofocus: widget.autofocus,
                    obscureText: obscureText,
                    textCapitalization: widget.textCapitalization,
                    style:
                        widget.textStyle ??
                        textStyles.regularBody14.copyWith(color: widget.color),
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    inputFormatters: [
                      ...?widget.inputFormatters,
                      if (widget.maxLength != null) ...[
                        LengthLimitingTextInputFormatter(widget.maxLength),
                      ],
                    ],
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      labelText: widget.label,
                      prefix: widget.prefix,
                      floatingLabelStyle: textStyles.boldBody13.copyWith(
                        fontSize: 14 * 1.4,
                        height: 1,
                        color: error != null
                            ? theme.error
                            : (widget.color ?? theme.textPrimary),
                      ),
                      hintMaxLines: widget.maxLines,
                    ),
                  ),
                ),
                _TrailingContent(
                  loading: widget.loading,
                  suffix: widget.suffix,
                  hasClearButton: widget.hasClearButton && value.isNotEmpty,
                  canObscureText: widget.canObscureText,
                  obscureText: obscureText,
                  maxLength: widget.maxLength,
                  value: value,
                  onCleared: onCleared,
                  onObscureToggled: () =>
                      setState(() => obscureText = !obscureText),
                ),
              ],
            ),
          ),
          AnimatedVisibility(
            visible: error != null && !widget.hideErrorText,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '* ${error ?? ''}',
                style: textStyles.regularBody14.copyWith(color: theme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Suffix slots after the input: loading indicator, custom suffix, clear
/// button, obscure toggle, and character counter — same order as
/// `AppTextField`.
class _TrailingContent extends StatelessWidget {
  const _TrailingContent({
    required this.loading,
    required this.suffix,
    required this.hasClearButton,
    required this.canObscureText,
    required this.obscureText,
    required this.maxLength,
    required this.value,
    required this.onCleared,
    required this.onObscureToggled,
  });

  final bool loading;
  final Widget? suffix;
  final bool hasClearButton;
  final bool canObscureText;
  final bool obscureText;
  final int? maxLength;
  final String value;
  final VoidCallback onCleared;
  final VoidCallback onObscureToggled;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Row(
      children: [
        if (loading) ...[
          const SizedBox(width: 12),
          const CustomCircularProgressIndicator.adaptive(size: 24),
        ] else if (suffix != null) ...[
          const SizedBox(width: 12),
          suffix!,
        ] else if (hasClearButton) ...[
          const SizedBox(width: 12),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onCleared,
            child: SvgPicture.asset(
              UiSvgIcons.closeMark,
              package: UiConsts.package,
            ),
          ),
        ] else if (canObscureText) ...[
          const SizedBox(width: 12),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onObscureToggled,
            child: SvgIcon(
              obscureText ? UiSvgIcons.eyeSlash : UiSvgIcons.eyeOpen,
              size: 20,
              color: theme.textSecondary,
            ),
          ),
        ],
        if (maxLength != null) ...[
          const SizedBox(width: 12),
          Text(
            value.isEmpty ? maxLength.toString() : '${value.length}/$maxLength',
            style: textStyles.regularBody13.copyWith(color: theme.textPrimary),
          ),
        ],
      ],
    );
  }
}
