import 'package:flutter/material.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/button/app_base_button.dart';

class EmptyListText extends StatelessWidget {
  /// A widget that displays a text and a button to refresh the list.
  ///
  /// * If [refresh] is not null, a button will be displayed with the text "Retry".
  const EmptyListText({
    required this.text,
    this.refresh,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? refresh;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: textStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (refresh != null) ...[
              const SizedBox(
                height: 16,
              ),
              AppBaseButton.flat(
                text: S.of(context).retry,
                onPressed: refresh,
                theme: theme,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
