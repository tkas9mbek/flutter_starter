import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/form/form_validators.dart';

import '../../support/pump_localized.dart';

void main() {
  late BuildContext context;

  Future<void> pump(WidgetTester tester) async =>
      context = await tester.pumpLocalizedContext();

  testWidgets('required rejects null, blank strings and empty lists', (
    tester,
  ) async {
    await pump(tester);
    final validator = FormValidators.required<Object>(context);

    for (final value in <Object?>[null, '', '   ', <int>[]]) {
      expect(validator(value), 'Required field', reason: '$value');
    }
    for (final value in <Object>[
      'a',
      0,
      false,
      <int>[1],
    ]) {
      expect(validator(value), isNull, reason: '$value');
    }
    expect(
      FormValidators.required<String>(context, message: 'Fill me')(''),
      'Fill me',
    );
  });

  testWidgets('url accepts http(s) hosts with a dot and skips empty input', (
    tester,
  ) async {
    await pump(tester);
    final validator = FormValidators.url<String>(context);

    expect(validator(null), isNull);
    expect(validator(' '), isNull);
    expect(validator('https://example.com'), isNull);
    expect(validator('HTTP://sub.example.co.uk/path?q=1'), isNull);
    expect(validator('ftp://example.com'), 'Invalid URL format');
    expect(validator('https://localhost'), 'Invalid URL format');
    expect(validator('example.com'), 'Invalid URL format');
  });

  testWidgets('email checks the shape of a trimmed address', (tester) async {
    await pump(tester);
    final validator = FormValidators.email(context);

    expect(validator(''), isNull);
    expect(validator('first.last+tag@mail.example.com'), isNull);
    expect(validator('  user@example.io  '), isNull);
    expect(validator('user@'), 'Invalid email format');
    expect(validator('user@localhost'), 'Invalid email format');
    expect(validator('user name@example.com'), 'Invalid email format');
    expect(
      FormValidators.email(context, message: 'Bad email')('nope'),
      'Bad email',
    );
  });

  testWidgets('passwordMinLength enforces the minimum and names it', (
    tester,
  ) async {
    await pump(tester);

    expect(FormValidators.passwordMinLength(context)(''), isNull);
    expect(
      FormValidators.passwordMinLength(context)('12345'),
      'Password must be at least 6 characters',
    );
    expect(FormValidators.passwordMinLength(context)('123456'), isNull);
    expect(
      FormValidators.passwordMinLength(context, minLength: 8)('1234567'),
      'Password must be at least 8 characters',
    );
  });

  testWidgets('phonePattern matches the digits after stripping the mask', (
    tester,
  ) async {
    await pump(tester);
    final validator = FormValidators.phonePattern(
      context,
      pattern: r'^7\d{10}$',
    );

    expect(validator(''), isNull);
    expect(validator('+7 (123) 456-78-90'), isNull);
    expect(validator('+7 (123) 456-78'), 'For example, +7 (123) 456-78-90');
    expect(validator('+8 (123) 456-78-90'), 'For example, +7 (123) 456-78-90');
  });

  testWidgets('phone accepts a raw length from 10 to 16 characters', (
    tester,
  ) async {
    await pump(tester);
    final validator = FormValidators.phone(context);

    expect(validator(''), isNull);
    expect(validator('123456789'), 'For example, +7 (123) 456-78-90');
    expect(validator('1234567890'), isNull);
    expect(validator('+123456789012345'), isNull);
    expect(validator('+1234567890123456'), 'For example, +7 (123) 456-78-90');
    expect(
      FormValidators.phone(context, message: 'Bad phone')('1'),
      'Bad phone',
    );
  });
}
