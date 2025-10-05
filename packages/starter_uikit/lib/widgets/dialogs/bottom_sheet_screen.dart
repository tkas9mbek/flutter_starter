import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class BottomSheetScreen extends StatelessWidget {
  /// A bottom sheet with rounded corners and a white background.
  /// * [child] is the content of the bottom sheet.
  /// * [title] is the title of the bottom sheet.
  /// * [closeButtonText] is the text of the close button.
  /// * [showCloseButton] determines whether the close button is shown.
  /// * [showResizeIndicator] determines whether the resize indicator is shown.
  /// * [onClosePressed] is the callback when the close button is pressed.
  /// * [padding] is the padding of the content.
  /// * [closeButtonAlignment] is the alignment of the close button.
  /// * [bgColor] is the background color of the bottom sheet.
  /// * [ignoreSafeArea] determines whether the bottom padding is ignored.
  /// * [bottomChild] is the content at the bottom of the bottom sheet.
  const BottomSheetScreen({
    required this.child,
    this.title,
    this.closeButtonText,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 20),
    this.onClosePressed,
    this.showCloseButton = true,
    this.showResizeIndicator = true,
    this.isDismissible = true,
    this.closeButtonAlignment = Alignment.centerLeft,
    this.bgColor,
    this.ignoreSafeArea = false,
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
  final bool isDismissible;
  final Widget? bottomChild;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return PopScope(
      canPop: isDismissible,
      child: Padding(
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
                                onTap: onClosePressed ??
                                    () => Navigator.pop(context),
                                child: Text(
                                  closeButtonText ?? UiLocalizer.of(context).back,
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
                            Text(
                              title!,
                              style: textStyles.boldTitle18,
                            ),
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
      ),
    );
  }

  /// Shows a bottom sheet with rounded corners and a white background.
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
      overlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      settings: RouteSettings(name: routeName),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      isDismissible: isDismissible,
      expand: expand,
      enableDrag: enableDrag,
      topControl: const SizedBox.shrink(),
      useRootNavigator: useRootNavigator,
      barrierColor: theme.border,
      context: context,
      builder: builder,
    );
  }
}
