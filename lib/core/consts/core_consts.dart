class CoreConsts {
  // Store URLs
  // Replace with your application store URLs before release.
  static const String appStoreUrl = 'https://apps.apple.com/app/id0000000000';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.example.app';

  // Keep in sync with pubspec.yaml version.
  static const String appVersion = '2.1.0';

  // Backend URLs
  static const String prodBaseUrl = 'https://example.com';
  static const String devBaseUrl = 'https://example.com';
  static const String prodGeneralApiUrl = '$prodBaseUrl/api/v1';
  static const String devGeneralApiUrl = '$devBaseUrl/api/v1';

  static const int apiTimeoutSeconds = 30;
  static const double heightPerMinute = 1.25;
}
