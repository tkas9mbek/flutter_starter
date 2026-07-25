import 'package:flutter/cupertino.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Overlays a localized "Done" bar above the on-screen keyboard whenever it
/// is visible, dismissing focus on tap and padding [child] so the bar never
/// covers content.
class InputAccessoryViewWrapper extends StatelessWidget {
  const InputAccessoryViewWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const buttonsHeight = 41.0;

    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final visibility = keyboardInset > 0;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: visibility ? buttonsHeight : 0),
          child: child,
        ),
        if (visibility) ...[
          Positioned(
            bottom: keyboardInset,
            left: 0,
            right: 0,
            child: Container(
              height: buttonsHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.surface,
                border: Border(
                  top: BorderSide(color: theme.border, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    child: Text(
                      UikitLocalizer.of(context).done,
                      style: textStyles.regularBody16.copyWith(
                        color: theme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
