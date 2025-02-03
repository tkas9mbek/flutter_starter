import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:uikit/generated/l10n.dart';
import 'package:uikit/theme/theme_provider.dart';

class InputAccessoryViewWrapper extends StatelessWidget {
  /// Wraps the [child] with an input accessory view that contains a "Done" button.
  /// The "Done" button will hide the keyboard when pressed.
  const InputAccessoryViewWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const buttonsHeight = 41.0;

    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return KeyboardVisibilityBuilder(
      builder: (context, visibility) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: visibility ? buttonsHeight : 0,
            ),
            child: child,
          ),
          if (visibility) ...[
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Container(
                height: buttonsHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border(
                    top: BorderSide(
                      color: theme.border,
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Text(
                        S.of(context).done,
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
      ),
    );
  }
}
