import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/functions/format_hours_minutes_seconds.dart';
import 'package:starter_toolkit/utils/functions/string_formatting_functions.dart';

void main() {
  test('capitalizeFirstLetter upper-cases only the first character', () {
    expect(capitalizeFirstLetter('hello world'), 'Hello world');
    expect(capitalizeFirstLetter('ёлка'), 'Ёлка');
    expect(capitalizeFirstLetter(''), '');
    expect(capitalizeFirstLetter(null), '');
  });

  test(
    'removeSpaceAndSymbols keeps word characters only',
    () => expect(removeSpaceAndSymbols(' a-b c_d!? 12 '), 'abc_d12'),
  );

  test(
    'cleanPhoneNumber strips mask characters but keeps the plus',
    () => expect(cleanPhoneNumber('+7 (123) 456-78-90'), '+71234567890'),
  );

  group('formatHoursMinutesSeconds', () {
    test('defaults to MM:SS', () {
      expect(formatHoursMinutesSeconds(65), '01:05');
      expect(formatHoursMinutesSeconds(0), '00:00');
    });

    test('adds hours once they are non-zero or requested', () {
      expect(formatHoursMinutesSeconds(3725), '01:02:05');
      expect(formatHoursMinutesSeconds(65, showHours: true), '00:01:05');
    });

    test('drops minutes or seconds on request', () {
      expect(formatHoursMinutesSeconds(65, showSeconds: false), '01');
      expect(formatHoursMinutesSeconds(65, showMinutes: false), '05');
      expect(formatHoursMinutesSeconds(3725, showSeconds: false), '01:02');
    });
  });
}
