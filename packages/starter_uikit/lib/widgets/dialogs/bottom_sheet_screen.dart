import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

const _topRadius = BorderRadius.vertical(top: Radius.circular(AppRadii.xl));

/// Scaffold for modal bottom sheets: a bordered `surface` panel with rounded
/// top corners, optional title, close button, drag handle, and a pinned
/// [bottomChild], adjusting for the keyboard. Present it with [show].
class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 24),
    this.showCloseButton = true,
    this.showResizeIndicator = true,
    this.closeButtonAlignment = Alignment.centerLeft,
    this.ignoreSafeArea = false,
    this.title,
    this.closeButtonText,
    this.onClosePressed,
    this.bgColor,
    this.bottomChild,
    super.key,
  });

  final Widget child;
  final String? title;
  final String? closeButtonText;
  final bool showCloseButton;
  final bool showResizeIndicator;
  final VoidCallback? onClosePressed;
  final EdgeInsets padding;
  final Alignment closeButtonAlignment;
  final Color? bgColor;
  final bool ignoreSafeArea;
  final Widget? bottomChild;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final bottomPadding = ignoreSafeArea
        ? padding.bottom
        : max(padding.bottom, MediaQuery.viewPaddingOf(context).bottom);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: bgColor ?? theme.surface,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: theme.border),
                  borderRadius: _topRadius,
                ),
              ),
              child: Padding(
                padding: padding.copyWith(bottom: bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (showCloseButton) ...[
                      Align(
                        alignment: closeButtonAlignment,
                        child: _CloseButton(
                          text: closeButtonText,
                          onPressed: onClosePressed,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else ...[
                      const SizedBox(height: 20),
                    ],
                    if (title?.isNotEmpty ?? false) ...[
                      Text(title!, style: textStyles.mediumTitle20),
                    ],
                    child,
                  ],
                ),
              ),
            ),
          ),
          if (bottomChild != null) ...[
            Positioned(
              bottom: 0,
              width: MediaQuery.sizeOf(context).width,
              child: bottomChild!,
            ),
          ],
          if (showResizeIndicator) ...[
            const Positioned(top: 8, child: _DragHandle()),
          ],
        ],
      ),
    );
  }

  /// Shows this sheet as a flat bordered `surface` modal with rounded top
  /// corners.
  ///
  /// When [isDismissible] is false the sheet can only be closed
  /// programmatically: barrier taps, drag, and the system back gesture are
  /// all blocked.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool expand = false,
    bool useRootNavigator = false,
    bool enableDrag = true,
    bool isDismissible = true,
    String? routeName,
  }) {
    final theme = ThemeProvider.of(context).theme;

    return showBarModalBottomSheet<T>(
      overlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
      settings: RouteSettings(name: routeName),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.border),
        borderRadius: _topRadius,
      ),
      // The package's container defaults to a white, elevation-2 Material.
      backgroundColor: theme.surface,
      elevation: 0,
      isDismissible: isDismissible,
      expand: expand,
      enableDrag: isDismissible && enableDrag,
      topControl: const SizedBox.shrink(),
      useRootNavigator: useRootNavigator,
      barrierColor: theme.border,
      context: context,
      builder: (context) =>
          PopScope(canPop: isDismissible, child: builder(context)),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({this.text, this.onPressed});

  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Text(
        text ?? UikitLocalizer.of(context).back,
        style: textStyles.mediumBody14.copyWith(color: theme.accent),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      height: 4,
      width: 36,
      decoration: BoxDecoration(
        color: theme.borderStrong,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
    );
  }
}
