import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Returns [height] floored at the device's bottom safe-area inset.
///
/// Useful for sticky bottom bars that must clear the home indicator.
double getSafeBottomHeight(BuildContext context, double height) =>
    math.max(MediaQuery.of(context).padding.bottom, height);
