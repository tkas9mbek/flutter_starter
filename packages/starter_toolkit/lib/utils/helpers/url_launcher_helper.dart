import 'package:starter_toolkit/configs/common_consts.dart';
import 'package:starter_toolkit/data/exceptions/url_launch_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> _launch(Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      await launchUrl(uri, mode: mode);
    } catch (e) {
      throw UrlLaunchException();
    }
  }

  static Future<void> launchPhone(String phone) async {
    await _launch(Uri(scheme: 'tel', path: phone));
  }

  static Future<void> launchMessenger(String baseUrl,
      String contact, {
        String message = '',
      }) async {
    final url = '$baseUrl$contact';
    await _launch(
      Uri.parse(message.isEmpty ? url : '$url?text=$message'),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<void> launchWhatsapp(String url) async {
    if (!url.startsWith(CommonConsts.whatsappBaseUrl)) {
      return _launch(
        Uri.parse(CommonConsts.whatsappBaseUrl + url),
        mode: LaunchMode.externalApplication,
      );
    }

    return _launch(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<void> launchTelegram(String url) async {
    if (!url.startsWith(CommonConsts.telegramBaseUrl)) {
      return _launch(
        Uri.parse(CommonConsts.telegramBaseUrl + url),
        mode: LaunchMode.externalApplication,
      );
    }

    return _launch(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<void> launchSms(String phone) async {
    await _launch(Uri(scheme: 'sms', path: phone));
  }

  static Future<void> launchStore(String url) async {
    await _launch(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<void> launchWebUrl(String url, {
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
