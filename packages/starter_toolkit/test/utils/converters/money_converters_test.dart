import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:starter_toolkit/utils/converters/money_converters.dart';

void main() {
  // Grouping and decimal separators come from the default locale.
  setUp(() => Intl.defaultLocale = 'en');
  tearDown(() => Intl.defaultLocale = null);

  test('amountToString groups thousands and appends the ruble sign', () {
    expect(MoneyConverters.amountToString(1234567), '1,234,567 ₽');
    expect(MoneyConverters.amountToString(99.6), '100 ₽');
  });

  test('amountToString honours a custom symbol, no symbol and the sign', () {
    expect(MoneyConverters.amountToString(1500, symbol: r'$'), r'1,500 $');
    expect(
      MoneyConverters.amountToString(1500, showSymbol: false).trim(),
      '1,500',
    );
    expect(MoneyConverters.amountToString(10, showSign: true), '+10 ₽');
    expect(MoneyConverters.amountToString(-10, showSign: true), '-10 ₽');
    expect(MoneyConverters.amountToString(0, showSign: true), '0 ₽');
  });

  test('formatDouble keeps up to two decimals and drops trailing zeros', () {
    expect(MoneyConverters.formatDouble(null), '');
    expect(MoneyConverters.formatDouble(3), '3');
    expect(MoneyConverters.formatDouble(3.456), '3.46');
    expect(MoneyConverters.formatDouble(1234.5), '1,234.5');
  });
}
