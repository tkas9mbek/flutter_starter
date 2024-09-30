import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_starter/core/consts.dart';
import 'package:flutter_starter/resources/resources.dart';
import 'package:flutter_starter/uikit/dialogs/bottom_sheet_screen.dart';
import 'package:flutter_starter/uikit/dialogs/dropdown_bottom_sheet.dart';
import 'package:flutter_starter/uikit/form/app_text_field.dart';
import 'package:flutter_starter/uikit/form/decoration/bordered_text_field_decoration.dart';
import 'package:flutter_starter/uikit/form/decoration/text_field_decoration.dart';
import 'package:flutter_starter/utils/form/option_label_builders.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDropdownField<T extends Object> extends StatefulWidget {
  /// Similar to [AppTextField], but with a dropdown.
  /// A dropdown field that allows the user to select an option from a list.
  /// The selected option is returned as a value when the form is submitted.
  /// * [options] is a list of options to choose from.
  /// * [optionLabelBuilder] is a function that converts an option to a string.
  /// By default, it uses the `toString` method.
  const AppDropdownField({
    required this.options,
    required this.name,
    this.label,
    this.title,
    this.hint,
    this.prefixText,
    this.initialValue,
    this.validator,
    this.decoration = const BorderedTextFieldDecoration(),
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.enabled = true,
    this.hideErrorText = true,
    this.colorLabelOnError = false,
    super.key,
  });

  final String name;

  final String? label;
  final String? title;
  final String? hint;
  final String? prefixText;
  final List<T> options;
  final String Function(T value) optionLabelBuilder;
  final T? initialValue;
  final String? Function(T?)? validator;
  final TextFieldDecoration decoration;

  final bool enabled;
  final bool hideErrorText;
  final bool colorLabelOnError;

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T extends Object>
    extends State<AppDropdownField<T>> {
  late final textFieldName = '${widget.name}_text';

  FormBuilderFieldState<FormBuilderField, dynamic>? controller;
  FormBuilderFieldState<FormBuilderField, dynamic>? textController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = FormBuilder.of(context)?.fields[widget.name];
      textController = FormBuilder.of(context)?.fields[textFieldName];
    });
  }

  Future<void> openOptionsSheet(
    BuildContext context, {
    required T? value,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final selected = await BottomSheetScreen.show(
      context: context,
      builder: (context) => DropdownBottomSheet<T>(
        title: widget.title ?? widget.label,
        options: widget.options,
        selected: value,
        optionLabelBuilder: widget.optionLabelBuilder,
      ),
    );

    if (selected != null) {
      controller?.didChange(selected);
      textController?.didChange(widget.optionLabelBuilder(selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: widget.name,
      initialValue: widget.initialValue,
      validator: widget.validator,
      builder: (field) => AppTextField(
        name: textFieldName,
        onTap: widget.enabled
            ? () => openOptionsSheet(context, value: field.value)
            : null,
        label: widget.label,
        hint: widget.hint,
        prefixText: widget.prefixText,
        decoration: widget.decoration,
        enabled: false,
        hideErrorText: widget.hideErrorText,
        colorLabelOnError: widget.colorLabelOnError,
        validator: (_) => field.errorText,
        initialValue: field.value == null
            ? null
            : widget.optionLabelBuilder(field.value!),
        suffix: SvgPicture.asset(
          SvgIcons.chevronRight
        ),
      ),
    );
  }
}
