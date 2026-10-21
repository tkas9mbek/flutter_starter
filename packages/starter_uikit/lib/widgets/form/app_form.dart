import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter_toolkit/utils/form/save_and_validate_form.dart';

/// [FormBuilder] that stays quiet until the first submit, then re-validates
/// as the user edits. Reach it with a `GlobalKey<AppFormState>`.
class AppForm extends StatefulWidget {
  const AppForm({required this.child, this.initialValue = const {}, super.key});

  final Widget child;
  final Map<String, dynamic> initialValue;

  /// The closest form above [context], for a field that depends on another.
  static AppFormState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<AppFormState>();

  @override
  State<AppForm> createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  final _builderKey = GlobalKey<FormBuilderState>();
  final _watchedFields = <String>{};
  var _autovalidateMode = AutovalidateMode.disabled;

  Map<String, dynamic> get value => _builderKey.currentState!.value;

  Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  get fields => _builderKey.currentState!.fields;

  /// Current value of the field called [name], or null.
  T? fieldValue<T>(String name) => _builderKey.currentState?.fields[name]?.value as T?;

  /// Saves and validates every field, scrolling to the first invalid one.
  /// Returns whether the form is valid.
  bool saveAndValidate() {
    if (_autovalidateMode != AutovalidateMode.onUserInteraction) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
    }

    return saveAndValidateForm(_builderKey);
  }

  /// Validates one field, for a button that needs only part of the form, and
  /// keeps re-validating it as the user edits. The other fields stay quiet.
  /// Returns whether the field is valid.
  bool validateField(String name) {
    _watchedFields.add(name);

    return fields[name]?.validate() ?? false;
  }

  void _revalidateWatchedFields() {
    for (final name in _watchedFields) {
      fields[name]?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _builderKey,
      autovalidateMode: _autovalidateMode,
      initialValue: widget.initialValue,
      onChanged: _revalidateWatchedFields,
      child: widget.child,
    );
  }
}
