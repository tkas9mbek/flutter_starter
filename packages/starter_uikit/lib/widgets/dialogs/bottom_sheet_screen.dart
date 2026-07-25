import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Scaffold for modal bottom sheets: rounded top corners, optional title,
/// close button, resize indicator, and a pinned [bottomChild], adjusting for
/// the keyboard. Use the static [show] method to present it as a modal sheet.
class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 20),
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

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: bgColor ?? theme.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: padding.copyWith(
                      bottom: ignoreSafeArea
                          ? padding.bottom
                          : max(
                              padding.bottom,
                              MediaQuery.of(context).viewPadding.bottom,
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (showCloseButton) ...[
                          Align(
                            alignment: closeButtonAlignment,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap:
                                  onClosePressed ??
                                  () => Navigator.pop(context),
                              child: Text(
                                closeButtonText ??
                                    UikitLocalizer.of(context).back,
                                style: textStyles.regularBody13.copyWith(
                                  color: theme.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 13),
                        ] else ...[
                          const SizedBox(height: 20),
                        ],
                        if (title?.isNotEmpty ?? false) ...[
                          Text(title!, style: textStyles.boldTitle18),
                        ],
                        child,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (bottomChild != null) ...[
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: bottomChild!,
            ),
          ],
          if (showResizeIndicator) ...[
            Positioned(
              top: 8,
              child: Container(
                height: 5,
                width: 36,
                decoration: BoxDecoration(
                  color: theme.border,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Shows a bottom sheet with rounded corners and a white background.
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
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
