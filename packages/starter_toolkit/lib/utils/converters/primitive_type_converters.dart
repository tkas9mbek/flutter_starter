import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrimitiveTypeConverters {
  static String stringFromJson(dynamic json) => json.toString();

  static Color colorFromJson(String json) {
    final buffer = StringBuffer();

    if (json.length == 6 || json.length == 7) {
      buffer.write('ff');
    }

    buffer.write(json.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String colorToJson(Color color) {
    final buffer = StringBuffer()
      ..write(color.value.toRadixString(16).padLeft(8, '0'));

    return buffer.toString();
  }

  static String? nullableDataToDashedString(DateTime? date) {
    final format = DateFormat('yyyy-MM-dd');

    return date == null ? null : format.format(date);
  }

  static int? nullableIntFromJson(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is num) {
      return json.toInt();
    } else if (json is String) {
      return int.tryParse(json);
    } else {
      throw Exception('Invalid type');
    }
  }

  static int intFromJson(dynamic json) {
    if (json is num) {
      return json.toInt();
    } else if (json is String) {
      return int.parse(json);
    } else {
      throw Exception('Invalid type');
    }
  }

  static double? nullableDoubleFromJson(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is num) {
      return json.toDouble();
    } else if (json is String) {
      return double.tryParse(json);
    } else {
      throw Exception('Invalid type');
    }
  }

  static bool boolFromJson(dynamic json) {
    if (json is bool) {
      return json;
    } else if (json is num) {
      return json.toInt() == 1;
    } else if (json is String) {
      return json == '1';
    } else {
      return false;
    }
  }

  static String dateToDashedString(DateTime date) {
    final format = DateFormat('yyyy-MM-dd');

    return format.format(date);
  }

  static String? nullableDateToDashedString(DateTime? date) {
    if (date == null) {
      return null;
    }

    final format = DateFormat('yyyy-MM-dd');

    return format.format(date);
  }
}
