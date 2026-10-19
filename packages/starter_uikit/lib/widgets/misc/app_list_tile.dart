import 'package:flutter/material.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Row for a `GroupedRowsCard`: leading [icon], [title] with optional
/// [subtitle], and a trailing [value] label. A tappable, non-[danger] row
/// without a custom [trailing] ends in a chevron; [loading] swaps it for a
/// spinner and ignores taps until it clears.
class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    this.danger = false,
    this.loading = false,
    this.icon,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Asset path from `UiSvgIcons`; tinted accent, or error when [danger].
  final String? icon;
  final String title;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final tint = danger ? theme.errorText : theme.accent;
    final showChevron = onTap != null && trailing == null && !danger;

    return AppTapArea(
      onTap: loading ? null : onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: LayoutBuilder(
            builder: (context, box) => Row(
              children: [
                if (icon != null) ...[
                  SvgIcon(icon!, size: 22, color: tint),
                  const SizedBox(width: 14),
                ],
                Expanded(
                  child: _TitleColumn(
                    title: title,
                    subtitle: subtitle,
                    danger: danger,
                  ),
                ),
                if (value != null) ...[
                  const SizedBox(width: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: box.maxWidth * 0.5),
                    child: Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: textStyles.regularBody14.copyWith(
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                ],
                if (loading) ...[
                  const SizedBox(width: 8),
                  CustomCircularProgressIndicator(size: 18, color: tint),
                ] else if (trailing != null) ...[
                  const SizedBox(width: 8),
                  trailing!,
                ] else if (showChevron) ...[
                  const SizedBox(width: 8),
                  SvgIcon(
                    UiSvgIcons.chevronRight,
                    size: 20,
                    color: theme.textTertiary,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleColumn extends StatelessWidget {
  const _TitleColumn({
    required this.title,
    required this.danger,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyles.mediumBody16.copyWith(
            color: danger ? theme.errorText : theme.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: textStyles.regularBody13.copyWith(
              color: theme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
