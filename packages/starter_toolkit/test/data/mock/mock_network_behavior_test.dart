import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class _FixedRandom implements Random {
  const _FixedRandom(this._value);

  final double _value;

  @override
  double nextDouble() => _value;

  @override
  bool nextBool() => _value >= 0.5;

  @override
  int nextInt(int max) => (_value * max).floor();
}

void main() {
  test('instant behavior never waits and never fails', () async {
    await const MockNetworkBehavior.instant().simulate();
  });

  test('simulate throws a backend-shaped error below the failure rate', () {
    const behavior = MockNetworkBehavior(
      wait: Duration.zero,
      failureRate: 0.5,
      random: _FixedRandom(0.1),
    );

    expect(behavior.simulate(), throwsA(isA<InternalServerErrorException>()));
  });

  test('simulate succeeds at or above the failure rate', () async {
    const behavior = MockNetworkBehavior(
      wait: Duration.zero,
      failureRate: 0.5,
      random: _FixedRandom(0.99),
    );

    await behavior.simulate();
  });

  test('delay waits without failing even at a 100% failure rate', () async {
    const behavior = MockNetworkBehavior(
      wait: Duration.zero,
      failureRate: 1,
      random: _FixedRandom(0),
    );

    await behavior.delay();
  });
}
