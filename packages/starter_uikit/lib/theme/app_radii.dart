/// Shared corner radii. Flat surfaces are told apart by border and radius
/// alone, so every rounded shape picks one of these steps.
class AppRadii {
  const AppRadii._();

  /// Checkboxes, tiny badges.
  static const double xs = 4;

  /// Pills, drag handles, small chips.
  static const double sm = 8;

  /// Cards, list tiles, segmented controls, grouped rows.
  static const double md = 12;

  /// Buttons and text fields.
  static const double control = 14;

  /// Dialogs, floating panels.
  static const double lg = 16;

  /// Snackbars, bottom sheet top corners.
  static const double xl = 20;

  /// Fully rounded (stadium) shapes.
  static const double pill = 100;
}
