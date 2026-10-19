import 'package:flutter/material.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/form/option_label_builders.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';

/// Sentinel type for dropdown options, letting a "no selection" entry be
/// distinguished from a `null` result caused by dismissing the sheet.
class NoValue {}

/// A bottom sheet presenting [options] as selectable cards, the [selected]
/// one highlighted. Pops with the tapped option, or with `null` when the
/// sheet is dismissed. Labels come from [optionLabelBuilder].
class DropdownBottomSheet<T extends Object> extends StatelessWidget {
  const DropdownBottomSheet({
    required this.options,
    this.showCloseButton = true,
    this.showResizeIndicator = true,
    this.optionLabelBuilder = defaultOptionLabelBuilder,
    this.selected,
    this.title,
    super.key,
  });

  final String? title;
  final bool showCloseButton;
  final bool showResizeIndicator;
  final List<T> options;
  final String Function(T value) optionLabelBuilder;
  final T? selected;

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreen(
      title: title,
      showCloseButton: showCloseButton,
      showResizeIndicator: showResizeIndicator,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final option in options) ...[
            const SizedBox(height: 8),
            _OptionCard(
              label: optionLabelBuilder(option),
              selected: option == selected,
              onTap: () => Navigator.pop(context, option),
            ),
          ],
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppCard(
      selected: selected,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: selected
                  ? textStyles.mediumBody16.copyWith(color: theme.accent)
                  : textStyles.regularBody16,
            ),
          ),
          if (selected) ...[
            const SizedBox(width: 12),
            SvgIcon(UiSvgIcons.tickMark, size: 20, color: theme.accent),
          ],
        ],
      ),
    );
  }
}
