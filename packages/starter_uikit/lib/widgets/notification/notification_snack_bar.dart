import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class NotificationSnackBar extends StatelessWidget {
  /// A notification bar that shows a message with an optional icon.
  /// The bar has a colored background and a text with a color.
  /// * If [iconPath] is not null, an icon will be shown before the text.
  const NotificationSnackBar({
    required this.text,
    required this.backgroundColor,
    required this.color,
    this.iconPath,
    super.key,
  });

  final String text;
  final String? iconPath;
  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(6),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <InlineSpan>[
                    if (iconPath != null) ...[
                      WidgetSpan(
                        child: SvgPicture.asset(
                          iconPath!,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 16)),
                    ],
                    TextSpan(
                      text: text,
                      style: textStyles.regularBody13.copyWith(
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a notification bar with a message.
  ///
  /// * If [isSuccess] is true, the bar will have a green background.
  /// * If [isSuccess] is false, the bar will have a red background.
  /// * If [iconPath] is not null, an icon will be shown before the text.
  static void showMessage(
    BuildContext context, {
    required bool isSuccess,
    required String message,
    String? iconPath,
  }) {
    final theme = ThemeProvider.of(context).theme;

    showTopSnackBar(
      Overlay.of(context),
      displayDuration: const Duration(seconds: 2),
      NotificationSnackBar(
        text: message,
        iconPath: iconPath,
        backgroundColor: isSuccess ? theme.success : theme.error,
        color: theme.onStatus,
      ),
    );
  }

  /// Shows a notification bar with a message from an exception.
  ///
  /// * If [iconPath] is not null, an icon will be shown before the text.
  /// * If the exception has a message, it will be shown in the bar.
  static void showExceptionMessage(
    BuildContext context, {
    required AppException exception,
  }) {
    final message = exception.getDescription(context);

    if (message.isNotEmpty) {
      showMessage(
        context,
        isSuccess: false,
        message: message,
      );
    }
  }
}
