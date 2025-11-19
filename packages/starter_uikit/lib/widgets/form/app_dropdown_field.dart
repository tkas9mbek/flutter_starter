import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/decoration/filled_text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';

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
    this.prefix,
    this.initialValue,
    this.validators,
    this.decoration = const FilledTextFieldDecoration(),
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.enabled = true,
    this.required = false,
    this.hideErrorText = true,
    this.colorLabelOnError = false,
    super.key,
  });

  final String name;

  final String? label;
  final String? title;
  final String? hint;
  final Widget? prefix;
  final List<T> options;
  final String Function(T value) optionLabelBuilder;
  final T? initialValue;
  final List<FormFieldValidator<T>>? validators;
  final TextFieldDecoration decoration;

  final bool enabled;
  final bool required;
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
      validator: FormBuilderValidators.compose([
        ...?widget.validators,
        if (widget.required) FormBuilderValidators.required(),
      ]),
      builder: (field) => AppTextField(
        name: textFieldName,
        onTap: widget.enabled
            ? () => openOptionsSheet(context, value: field.value)
            : null,
        label: widget.label,
        hint: widget.hint,
        prefix: widget.prefix,
        decoration: widget.decoration,
        readOnly: true,
        hideErrorText: widget.hideErrorText,
        colorLabelOnError: widget.colorLabelOnError,
        validators: [(_) => field.errorText],
        initialValue: field.value == null
            ? null
            : widget.optionLabelBuilder(field.value!),
        suffix: SvgPicture.asset(
          UiSvgIcons.chevronRight,
          package: UiConsts.package,
        ),
      ),
    );
  }
}
