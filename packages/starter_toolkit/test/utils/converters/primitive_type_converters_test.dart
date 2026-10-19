import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/converters/primitive_type_converters.dart';

void main() {
  test('colors parse with or without # and alpha, and serialize as ARGB', () {
    expect(
      PrimitiveTypeConverters.colorFromJson('#FF0000'),
      const Color(0xFFFF0000),
    );
    expect(
      PrimitiveTypeConverters.colorFromJson('00ff00'),
      const Color(0xFF00FF00),
    );
    expect(
      PrimitiveTypeConverters.colorFromJson('800000ff'),
      const Color(0x800000FF),
    );
    expect(
      PrimitiveTypeConverters.colorToJson(const Color(0x0A0000FF)),
      '0a0000ff',
    );
  });

  test('int parsing accepts numbers and numeric strings', () {
    expect(PrimitiveTypeConverters.intFromJson(3.9), 3);
    expect(PrimitiveTypeConverters.intFromJson('42'), 42);
    expect(() => PrimitiveTypeConverters.intFromJson(true), throwsException);

    expect(PrimitiveTypeConverters.nullableIntFromJson(null), isNull);
    expect(PrimitiveTypeConverters.nullableIntFromJson('x'), isNull);
    expect(PrimitiveTypeConverters.nullableIntFromJson('7'), 7);
    expect(PrimitiveTypeConverters.nullableIntFromJson(7.2), 7);
    expect(
      () => PrimitiveTypeConverters.nullableIntFromJson([]),
      throwsException,
    );
  });

  test('double parsing accepts numbers and numeric strings', () {
    expect(PrimitiveTypeConverters.nullableDoubleFromJson(null), isNull);
    expect(PrimitiveTypeConverters.nullableDoubleFromJson(2), 2.0);
    expect(PrimitiveTypeConverters.nullableDoubleFromJson('2.5'), 2.5);
    expect(PrimitiveTypeConverters.nullableDoubleFromJson('n/a'), isNull);
    expect(
      () => PrimitiveTypeConverters.nullableDoubleFromJson({}),
      throwsException,
    );
  });

  test(
    'bool parsing treats 1 and "1" as true and anything unknown as false',
    () {
      expect(PrimitiveTypeConverters.boolFromJson(true), isTrue);
      expect(PrimitiveTypeConverters.boolFromJson(1), isTrue);
      expect(PrimitiveTypeConverters.boolFromJson('1'), isTrue);
      expect(PrimitiveTypeConverters.boolFromJson(0), isFalse);
      expect(PrimitiveTypeConverters.boolFromJson('true'), isFalse);
      expect(PrimitiveTypeConverters.boolFromJson(null), isFalse);
    },
  );

  test('dates serialize as yyyy-MM-dd and null stays null', () {
    final date = DateTime(2026, 1, 5, 23, 59);

    expect(PrimitiveTypeConverters.dateToDashedString(date), '2026-01-05');
    expect(
      PrimitiveTypeConverters.nullableDateToDashedString(date),
      '2026-01-05',
    );
    expect(PrimitiveTypeConverters.nullableDateToDashedString(null), isNull);
    expect(
      PrimitiveTypeConverters.nullableDataToDashedString(date),
      '2026-01-05',
    );
    expect(PrimitiveTypeConverters.nullableDataToDashedString(null), isNull);
    expect(PrimitiveTypeConverters.stringFromJson(12), '12');
  });
}
