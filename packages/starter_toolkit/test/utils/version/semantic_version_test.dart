import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/version/semantic_version.dart';

SemanticVersion _v(String value) => SemanticVersion.parse(value);

void main() {
  test('compares segments numerically, not lexically', () {
    expect(_v('1.0.10').compareTo(_v('1.0.9')), greaterThan(0));
    expect(_v('2.0.0').compareTo(_v('10.0.0')), lessThan(0));
  });

  test('missing trailing and non-numeric segments count as zero', () {
    expect(_v('1.2').compareTo(_v('1.2.0')), 0);
    expect(_v(' 1.2.beta ').compareTo(_v('1.2.0')), 0);
    expect(_v('1.2.0.1').compareTo(_v('1.2')), greaterThan(0));
  });

  test('isBelow and isAtLeast gate forced updates', () {
    final minimum = _v('3.1.0');

    expect(_v('3.0.9').isBelow(minimum), isTrue);
    expect(_v('3.1.0').isBelow(minimum), isFalse);
    expect(_v('3.1.0').isAtLeast(minimum), isTrue);
    expect(_v('3.0.9').isAtLeast(minimum), isFalse);
  });
}
