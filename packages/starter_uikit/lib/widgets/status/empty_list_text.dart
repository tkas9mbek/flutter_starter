import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

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
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: textStyles.regularBody14,
              textAlign: TextAlign.center,
            ),
            if (refresh != null) ...[
              const SizedBox(
                height: 16,
              ),
              AppOutlinedButton.medium(
                context: context,
                text: UiLocalizer.of(context).retry,
                onPressed: refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
