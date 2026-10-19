import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_radii.dart';

void main() => test('AppRadii steps grow strictly from xs to pill', () {
  const steps = [
    AppRadii.xs,
    AppRadii.sm,
    AppRadii.md,
    AppRadii.control,
    AppRadii.lg,
    AppRadii.xl,
    AppRadii.pill,
  ];

  for (var i = 1; i < steps.length; i++) {
    expect(steps[i], greaterThan(steps[i - 1]));
  }
});
