// ignore_for_file: class_size_warning — bar visuals and overlay lifecycle form one notification unit

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

enum _NotificationSnackBarStyle { success, error, information }

/// Top-of-screen notification bar with a themed background, message text and
/// a leading icon.
///
/// Create via [NotificationSnackBar.success], [NotificationSnackBar.error] or
/// [NotificationSnackBar.information] — each has a default icon that can be
/// overridden via `iconPath` — and present it with [show].
class NotificationSnackBar extends StatelessWidget {
  const NotificationSnackBar._(
    this._style, {
    required this.text,
    required this.iconPath,
    super.key,
  });

  /// Green bar for successful operations.
  factory NotificationSnackBar.success({
    required String text,
    String iconPath = UiSvgIcons.checkMark,
    Key? key,
  }) => NotificationSnackBar._(
    _NotificationSnackBarStyle.success,
    text: text,
    iconPath: iconPath,
    key: key,
  );

  /// Red bar for failures.
  factory NotificationSnackBar.error({
    required String text,
    String iconPath = UiSvgIcons.closeMark,
    Key? key,
  }) => NotificationSnackBar._(
    _NotificationSnackBarStyle.error,
    text: text,
    iconPath: iconPath,
    key: key,
  );

  /// Primary-colored bar for neutral information.
  factory NotificationSnackBar.information({
    required String text,
    String iconPath = UiSvgIcons.notificationBell,
    Key? key,
  }) => NotificationSnackBar._(
    _NotificationSnackBarStyle.information,
    text: text,
    iconPath: iconPath,
    key: key,
  );

  final String text;
  final String iconPath;
  final _NotificationSnackBarStyle _style;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    final backgroundColor = switch (_style) {
      _NotificationSnackBarStyle.success => theme.success,
      _NotificationSnackBarStyle.error => theme.error,
      _NotificationSnackBarStyle.information => theme.primary,
    };
    final color = theme.onStatus;

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
                    WidgetSpan(
                      child: SvgPicture.asset(
                        iconPath,
                        package: UiConsts.package,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 16)),
                    TextSpan(
                      text: text,
                      style: textStyles.regularBody13.copyWith(color: color),
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

  /// Shows a [NotificationSnackBar.error] bar with the exception's
  /// snackbar description, if it has one.
  static void showExceptionMessage(
    BuildContext context, {
    required AppException exception,
  }) {
    final uiModel = ExceptionUiMapper(context).map(exception);
    final message = uiModel.snackbarDescription;

    if (message.isNotEmpty) {
      show(context, NotificationSnackBar.error(text: message));
    }
  }

  /// Inserts [child] as a self-managed overlay entry that slides in from the
  /// top, auto-dismisses, and can be dismissed early by tapping.
  static void show(BuildContext context, NotificationSnackBar child) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) =>
          _NotificationOverlay(onDismissed: entry.remove, child: child),
    );

    overlay.insert(entry);
  }
}

/// Slides the notification in from the top, auto-dismisses, and removes its
/// overlay entry. Tapping dismisses early.
class _NotificationOverlay extends StatefulWidget {
  const _NotificationOverlay({required this.child, required this.onDismissed});

  final Widget child;
  final VoidCallback onDismissed;

  @override
  State<_NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<_NotificationOverlay>
    with SingleTickerProviderStateMixin {
  static const _visibleDuration = Duration(seconds: 2);

  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offset = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    unawaited(_controller.forward());
    _timer = Timer(_visibleDuration, dismiss);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();

    super.dispose();
  }

  void dismiss() {
    _timer?.cancel();

    if (!mounted) {
      return;
    }

    unawaited(_hide());
  }

  Future<void> _hide() async {
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SlideTransition(
            position: _offset,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: dismiss,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
