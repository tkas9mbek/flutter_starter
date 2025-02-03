import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uikit/resources/resources.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:uikit/widgets/form/decoration/text_field_decoration.dart';
import 'package:uikit/widgets/status/custom_circular_progress_indicator.dart';

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
    this.prefixText,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,
    this.suffix,
    this.decoration = const FilledTextFieldDecoration(),
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.enabled = true,
    this.hideErrorText = true,
    this.hasClearButton = true,
    this.colorLabelOnError = false,
    this.loading = false,
    this.maxLength,
    this.color,
    this.focusNode,
    super.key,
  });

  final String name;

  final String? label;
  final String? hint;
  final String? prefixText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final VoidCallback? onTap;
  final Widget? suffix;
  final int? maxLines;
  final int? minLines;
  final TextFieldDecoration decoration;
  final Color? color;
  final int? maxLength;
  final FocusNode? focusNode;

  final bool autofocus;
  final bool hideErrorText;
  final bool hasClearButton;
  final bool colorLabelOnError;
  final bool loading;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FormBuilderFieldState<FormBuilderField, dynamic>? controller;
  String? value;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = FormBuilder.of(context)?.fields[widget.name];

      setState(() => value = controller?.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: widget.decoration.build(
        context,
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: widget.name,
                focusNode: widget.focusNode,
                onChanged: (v) {
                  widget.onChanged?.call(v);
                  setState(() => value = v);
                },
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                style: textStyles.regularBody14.copyWith(color: widget.color),
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                validator: widget.validator,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                initialValue: widget.initialValue,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  labelText: widget.label,
                  prefixText: widget.prefixText,
                  errorStyle: widget.hideErrorText
                      ? const TextStyle(height: -10, fontSize: 0)
                      : textStyles.regularBody13.copyWith(
                          color: theme.error,
                        ),
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
                child: SvgPicture.asset(SvgIcons.cross),
              ),
            ],
            if (widget.maxLength != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  (value?.isEmpty ?? true)
                      ? widget.maxLength.toString()
                      : '${value?.length ?? 0}/${widget.maxLength}',
                  style: textStyles.regularBody13
                      .copyWith(color: theme.textPrimary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
