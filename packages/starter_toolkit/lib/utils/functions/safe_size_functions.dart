import 'dart:math' as math;

import 'package:flutter/material.dart';

double getSafeBottomHeight(BuildContext context, double height) {
  return math.max(MediaQuery.of(context).padding.bottom, height);
}
