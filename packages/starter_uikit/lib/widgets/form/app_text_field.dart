import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/form/decoration/field_error_text.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_visual_state.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Themed text field wrapping [FormBuilderTextField] in a customizable
/// [TextFieldDecoration], with optional clear/obscure/loading suffixes,
/// character counter, and animated inline error text below the box.
class AppTextField extends StatefulWidget {
  /// Non-obvious params:
  /// * [hasClearButton] requires a parent [FormBuilder] to work.
  /// * [loading] shows a loading indicator in place of the clear button.
  /// * [prefixWidget] is always visible inside the field box before the input.
  const AppTextField({
    required this.name,
    this.decoration = const FilledTextFieldDecoration(),
    this.maxLines = 1,
    this.minLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.hideErrorText = false,
    this.hasClearButton = false,
    this.colorLabelOnError = false,
    this.loading = false,
    this.required = false,
    this.canObscureText = false,
    this.label,
    this.hint,
    this.prefix,
    this.prefixWidget,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.validators,
    this.onChanged,
    this.onTap,
    this.suffix,
    this.textStyle,
    this.maxLength,
    this.color,
    this.focusNode,
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? prefixWidget;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final List<String? Function(String?)>? validators;
  final Function(String?)? onChanged;
  final VoidCallback? onTap;
  final Widget? suffix;
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
  final bool colorLabelOnError;
  final bool loading;
  final bool enabled;
  final bool readOnly;
  final bool required;
  final bool canObscureText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FormBuilderFieldState<FormBuilderField, dynamic>? controller;
  String? value;
  String? errorText;
  bool focused = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();

    obscureText = widget.canObscureText;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      controller = FormBuilder.of(context)?.fields[widget.name];
      setState(() => value = controller?.value);
    });
  }

  String? validateField(String? value) {
    if (widget.validators != null && widget.validators!.isNotEmpty) {
      for (final validator in widget.validators!) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
    }

    if (widget.required) {
      return FormValidators.required(context)(value);
    }

    return null;
  }

  /// Autovalidation runs the validator while the field builds, when setState
  /// is not allowed; the error then appears on the next frame.
  void showError(String? error) {
    if (errorText == error) {
      return;
    }

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => errorText = error);
        }
      });

      return;
    }

    setState(() => errorText = error);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final state = TextFieldVisualState.resolve(
      enabled: widget.enabled,
      focused: focused,
      hasError: errorText != null,
    );
    final inputColor = widget.enabled ? widget.color : theme.textTertiary;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.enabled ? widget.onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
            canRequestFocus: false,
            skipTraversal: true,
            onFocusChange: (hasFocus) => setState(() => focused = hasFocus),
            child: widget.decoration.buildWithState(
              context,
              Row(
                children: [
                  if (widget.prefixWidget != null) ...[
                    widget.prefixWidget!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: FormBuilderTextField(
                      name: widget.name,
                      focusNode: widget.focusNode,
                      onTap: widget.onTap,
                      onChanged: (v) {
                        widget.onChanged?.call(v);
                        setState(() => value = v);
                      },
                      enabled: widget.enabled,
                      readOnly: widget.readOnly,
                      autofocus: widget.autofocus,
                      obscureText: obscureText,
                      textCapitalization: widget.textCapitalization,
                      style:
                          widget.textStyle ??
                          textStyles.regularBody14.copyWith(color: inputColor),
                      keyboardType: widget.keyboardType,
                      inputFormatters: [
                        ...?widget.inputFormatters,
                        if (widget.maxLength != null) ...[
                          LengthLimitingTextInputFormatter(widget.maxLength),
                        ],
                      ],
                      validator: (value) {
                        final error = validateField(value);
                        showError(error);

                        return error;
                      },
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      initialValue: widget.initialValue,
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        labelText: widget.label,
                        prefix: widget.prefix,
                        // Collapses Material's error line; FieldErrorText draws
                        // the message below the box instead.
                        errorStyle: textStyles.regularBody10.copyWith(
                          fontSize: 0,
                          height: -10,
                        ),
                        // Floating labels render at 3/4 size, so 16 lands on 12.
                        floatingLabelStyle: textStyles.mediumBody16.copyWith(
                          color: state.labelColor(
                            theme,
                            colorError: widget.colorLabelOnError,
                          ),
                        ),
                        hintMaxLines: widget.maxLines,
                      ),
                    ),
                  ),
                  if (widget.loading) ...[
                    const SizedBox(width: 12),
                    const CustomCircularProgressIndicator.adaptive(size: 20),
                  ] else if (widget.suffix != null) ...[
                    const SizedBox(width: 12),
                    widget.suffix!,
                  ] else if (widget.hasClearButton &&
                      (value?.isNotEmpty ?? false)) ...[
                    const SizedBox(width: 12),
                    AppTapArea(
                      onTap: () => controller?.didChange(null),
                      semanticLabel: UikitLocalizer.of(context).clearField,
                      child: SvgIcon(
                        UiSvgIcons.closeMark,
                        size: 20,
                        color: theme.textTertiary,
                      ),
                    ),
                  ] else if (widget.canObscureText) ...[
                    const SizedBox(width: 12),
                    AppTapArea(
                      onTap: () => setState(() => obscureText = !obscureText),
                      semanticLabel: UikitLocalizer.of(
                        context,
                      ).togglePasswordVisibility,
                      child: SvgIcon(
                        obscureText ? UiSvgIcons.eyeSlash : UiSvgIcons.eyeOpen,
                        size: 20,
                        color: theme.textTertiary,
                      ),
                    ),
                  ],
                  if (widget.maxLength != null) ...[
                    const SizedBox(width: 12),
                    Text(
                      (value?.isEmpty ?? true)
                          ? widget.maxLength.toString()
                          : '${value?.length ?? 0}/${widget.maxLength}',
                      style: textStyles.regularBody12.copyWith(
                        color: theme.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
              state,
            ),
          ),
          FieldErrorText(
            visible: errorText != null && !widget.hideErrorText,
            errorText: errorText,
          ),
        ],
      ),
    );
  }
}
