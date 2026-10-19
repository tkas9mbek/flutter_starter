import 'package:flutter/material.dart';

/// Raw palette, named by hue and shade. Widgets read `AppTheme` instead, so a
/// role (primary, border, error, ...) can be reassigned without renaming a
/// color here. Navy is the brand; the slate neutrals and ink darks carry a
/// blue tint so every surface sits in the same family as the brand.
class AppColors {
  static const Color transparent = Color(0x00000000);

  // Navy (brand), lightest to darkest.
  static const Color navy50 = Color(0xFFEEF2FA);
  static const Color navy100 = Color(0xFFDCE4F3);
  static const Color navy200 = Color(0xFFB7C5E4);
  static const Color navy300 = Color(0xFF8DA3D2);
  static const Color navy400 = Color(0xFF5F7DBB);
  static const Color navy500 = Color(0xFF2F55A4);
  static const Color navy600 = Color(0xFF254485);
  static const Color navy700 = Color(0xFF1A3369);
  static const Color navy800 = Color(0xFF11244D);
  static const Color navy900 = Color(0xFF0A1733);
  static const Color navyFaint = Color(0x332F55A4);

  // Slate neutrals for light surfaces and text, lightest to darkest.
  static const Color white = Color(0xFFFFFFFF);
  static const Color slate50 = Color(0xFFF5F7FB);
  static const Color slate100 = Color(0xFFEDF0F6);
  static const Color slate200 = Color(0xFFDFE4EE);
  static const Color slate300 = Color(0xFFC9D1E0);
  static const Color slate400 = Color(0xFFA3AEC4);
  static const Color slate500 = Color(0xFF75819A);
  static const Color slate700 = Color(0xFF4A5670);

  // Ink neutrals for dark surfaces and text, darkest to lightest.
  static const Color ink900 = Color(0xFF0A1226);
  static const Color ink800 = Color(0xFF101A33);
  static const Color ink700 = Color(0xFF17223F);
  static const Color ink600 = Color(0xFF223056);
  static const Color ink500 = Color(0xFF263356);
  static const Color ink400 = Color(0xFF364670);
  static const Color ink300 = Color(0xFF5E6B8A);
  static const Color ink200 = Color(0xFF7C89A6);
  static const Color ink100 = Color(0xFFA9B4CC);
  static const Color ink50 = Color(0xFFF1F4FA);

  // Cyan (secondary).
  static const Color cyan400 = Color(0xFF2DB4D4);
  static const Color cyan700 = Color(0xFF0E7490);

  // Status fills: deep shades that carry white text in either brightness.
  static const Color greenDark = Color(0xFF1B7A3E);
  static const Color redDark = Color(0xFFB3261E);
  static const Color orangeDark = Color(0xFFB45309);
  static const Color blueDark = Color(0xFF2358C9);

  // Status shades readable as text or icons on a dark background.
  static const Color greenLight = Color(0xFF4FBF7A);
  static const Color redLight = Color(0xFFF2877F);
}
