import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

class AppTextField extends StatefulWidget {
  /// Base text field widget that customizes [FormBuilderTextField].
  ///
  /// * [name] - name of the field in the form required for [FormBuilder].
  /// * [hasClearButton] requires widget to have a parent [FormBuilder] to work.
  /// * [colorLabelOnError] changes label color to error color if field is invalid.
  /// * [loading] shows loading indicator instead of clear button.
  /// * [hideErrorText] hides error text below the text field when field is invalid.
  /// * [decoration] - concrete implementation of [TextFieldDecoration].
  const AppTextField({
    required this.name,
    this.label,
    this.hint,
    this.prefix,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.validators,
    this.onChanged,
    this.onTap,
    this.suffix,
    this.decoration = const FilledTextFieldDecoration(),
    this.maxLines = 1,
    this.minLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.hideErrorText = false,
    this.hasClearButton = false,
    this.colorLabelOnError = false,
    this.loading = false,
    this.required = false,
    this.canObscureText = false,
    this.maxLength,
    this.color,
    this.focusNode,
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final Widget? prefix;
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
  late bool obscureText;

  @override
  void initState() {
    super.initState();

    obscureText = widget.canObscureText;
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

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
                    style: widget.textStyle ??
                        textStyles.regularBody14.copyWith(color: widget.color),
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    validator: (value) {
                      final error = validateField(value);
                      setState(() => errorText = error);

                      return error;
                    },
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    initialValue: widget.initialValue,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      labelText: widget.label,
                      prefix: widget.prefix,
                      errorStyle: const TextStyle(height: -10, fontSize: 0),
                      floatingLabelStyle: textStyles.regularBody13.copyWith(
                        fontSize: 12 * 1.4,
                        height: 1,
                        color: (widget.colorLabelOnError &&
                                !(controller?.isValid ?? true))
                            ? theme.error
                            : (widget.color ?? theme.textPrimary),
                      ),
                      hintMaxLines: widget.maxLines,
                    ),
                  ),
                ),
                if (widget.loading) ...[
                  const SizedBox(width: 12),
                  const CustomCircularProgressIndicator(size: 24),
                ] else if (widget.suffix != null) ...[
                  const SizedBox(width: 12),
                  widget.suffix!,
                ] else if (widget.hasClearButton &&
                    (value?.isNotEmpty ?? false)) ...[
                  const SizedBox(width: 12),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => controller?.didChange(null),
                    child: SvgPicture.asset(
                      UiSvgIcons.cross,
                      package: UiConsts.package,
                    ),
                  ),
                ] else if (widget.canObscureText) ...[
                  const SizedBox(width: 12),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => setState(() => obscureText = !obscureText),
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: theme.textSecondary,
                    ),
                  ),
                ],
                if (widget.maxLength != null) ...[
                  const SizedBox(width: 12),
                  Text(
                    (value?.isEmpty ?? true)
                        ? widget.maxLength.toString()
                        : '${value?.length ?? 0}/${widget.maxLength}',
                    style: textStyles.regularBody13
                        .copyWith(color: theme.textPrimary),
                  ),
                ],
              ],
            ),
          ),
          if (errorText != null && !widget.hideErrorText) ...[
            const SizedBox(height: 6),
            Text(
              '* $errorText',
              style: textStyles.regularBody14.copyWith(color: theme.error),
            ),
          ],
        ],
      ),
    );
  }
}
