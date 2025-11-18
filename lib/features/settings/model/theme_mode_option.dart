enum ThemeModeOption {
  light,
  dark,
  system;

  factory ThemeModeOption.fromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeModeOption.light;
      case 'dark':
        return ThemeModeOption.dark;
      case 'system':
        return ThemeModeOption.system;
      default:
        return ThemeModeOption.system;
    }
  }

  @override
  String toString() {
    switch (this) {
      case ThemeModeOption.light:
        return 'light';
      case ThemeModeOption.dark:
        return 'dark';
      case ThemeModeOption.system:
        return 'system';
    }
  }
}

const ThemeModeOption defaultThemeModeOption = ThemeModeOption.system;
