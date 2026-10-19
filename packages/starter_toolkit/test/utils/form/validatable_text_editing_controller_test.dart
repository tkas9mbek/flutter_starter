import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/form/validatable_text_editing_controller.dart';

String? _notEmpty(String? value) =>
    value == null || value.isEmpty ? 'empty' : null;

String? _maxThree(String? value) =>
    (value?.length ?? 0) > 3 ? 'too long' : null;

void main() {
  test('stays unvalidated until validate is called', () {
    final controller = ValidatableTextEditingController(
      validators: [_notEmpty],
    );
    addTearDown(controller.dispose);

    expect(controller.error, isNull);
  });

  test('validate publishes the first failing rule', () {
    final controller = ValidatableTextEditingController(
      validators: [_notEmpty, _maxThree],
    );
    addTearDown(controller.dispose);

    expect(controller.validate(), isFalse);
    expect(controller.error, 'empty');

    controller.text = 'abcd';
    expect(controller.validate(), isFalse);
    expect(controller.error, 'too long');

    controller.text = 'abc';
    expect(controller.validate(), isTrue);
    expect(controller.error, isNull);
  });

  test('notifies listeners only when the error changes', () {
    final controller = ValidatableTextEditingController(
      validators: [_notEmpty],
    );
    addTearDown(controller.dispose);
    var notifications = 0;
    controller.addListener(() => notifications++);

    controller
      ..validate()
      ..validate();
    expect(notifications, 1);

    controller.resetValidation();
    expect(controller.error, isNull);
    expect(notifications, 2);

    controller.resetValidation();
    expect(notifications, 2);
  });

  test('validateAll surfaces every error and reports overall validity', () {
    final empty = ValidatableTextEditingController(validators: [_notEmpty]);
    final long = ValidatableTextEditingController(
      validators: [_maxThree],
      text: 'abcd',
    );
    final valid = ValidatableTextEditingController(
      validators: [_notEmpty],
      text: 'ok',
    );
    addTearDown(empty.dispose);
    addTearDown(long.dispose);
    addTearDown(valid.dispose);

    expect(
      ValidatableTextEditingController.validateAll([empty, long, valid]),
      isFalse,
    );
    expect(empty.error, 'empty');
    expect(long.error, 'too long');
    expect(valid.error, isNull);

    expect(ValidatableTextEditingController.validateAll([valid]), isTrue);
  });
}
