import 'package:starter_toolkit/configs/common_consts.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches phone, messaging, web, and store URLs through `url_launcher`.
///
/// Throws [UrlLaunchFailedException] when the platform refuses to handle
/// the URL.
class UrlLauncherHelper {
  static Future<void> _launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      await launchUrl(uri, mode: mode);
    } catch (e) {
      throw const UrlLaunchFailedException();
    }
  }

  /// Opens the dialer with [phone] pre-filled.
  static Future<void> launchPhone(String phone) async {
    await _launch(Uri(scheme: 'tel', path: phone));
  }

  /// Opens a generic messenger by joining [baseUrl] and [contact],
  /// optionally appending a `?text=` query with [message].
  static Future<void> launchMessenger(
    String baseUrl,
    String contact, {
    String message = '',
  }) async {
    final url = '$baseUrl$contact';
    await _launch(
      Uri.parse(message.isEmpty ? url : '$url?text=$message'),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Opens WhatsApp at [url], prepending the WhatsApp base URL when needed.
  static Future<void> launchWhatsapp(String url) async {
    if (!url.startsWith(CommonConsts.whatsappBaseUrl)) {
      return _launch(
        Uri.parse(CommonConsts.whatsappBaseUrl + url),
        mode: LaunchMode.externalApplication,
      );
    }

    return _launch(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  /// Opens Telegram at [url], prepending the Telegram base URL when needed.
  static Future<void> launchTelegram(String url) async {
    if (!url.startsWith(CommonConsts.telegramBaseUrl)) {
      return _launch(
        Uri.parse(CommonConsts.telegramBaseUrl + url),
        mode: LaunchMode.externalApplication,
      );
    }

    return _launch(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  /// Opens the system SMS composer with [phone] pre-filled.
  static Future<void> launchSms(String phone) async {
    await _launch(Uri(scheme: 'sms', path: phone));
  }

  /// Opens the App Store / Play Store URL [url] in the external app.
  static Future<void> launchStore(String url) async {
    await _launch(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  /// Opens [url] in an in-app web view, or in the external browser when
  /// [useExternalBrowser] is `true`.
  static Future<void> launchWebUrl(
    String url, {
    bool useExternalBrowser = false,
  }) async {
    await _launch(
      Uri.parse(url),
      mode: useExternalBrowser
          ? LaunchMode.externalApplication
          : LaunchMode.inAppWebView,
    );
  }
}
