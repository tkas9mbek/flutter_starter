import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Displays a localized failure message for an [AppException] with an
/// optional retry action.
///
/// Use [FailureWidget.large] for full-screen failure states and
/// [FailureWidget.small] for compact inline failure rows.
abstract class FailureWidget extends StatelessWidget {
  const FailureWidget._({required this.exception, this.onRetry, super.key});

  /// Full-screen failure body with a description and a retry button.
  const factory FailureWidget.large({
    required AppException exception,
    VoidCallback? onRetry,
    Key? key,
  }) = _FailureWidgetLarge;

  /// Compact single-row failure message with an optional retry icon.
  const factory FailureWidget.small({
    required AppException exception,
    VoidCallback? onRetry,
    Color? textColor,
    Key? key,
  }) = _FailureWidgetSmall;

  final AppException exception;
  final VoidCallback? onRetry;
}

class _FailureWidgetLarge extends FailureWidget {
  const _FailureWidgetLarge({
    required super.exception,
    super.onRetry,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final uiModel = ExceptionUiMapper(context).map(exception);
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            SvgIcon(UiSvgIcons.infoCircle, size: 48, color: theme.errorText),
            const SizedBox(height: 16),
            Text(
              uiModel.description,
              style: textStyles.mediumBody16,
              textAlign: TextAlign.center,
            ),
            if (uiModel.canRetry && onRetry != null) ...[
              const SizedBox(height: 8),
              Text(
                localizer.tryRefreshPage,
                style: textStyles.regularBody14.copyWith(
                  color: theme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppOutlinedButton.medium(
                context: context,
                text: localizer.retry,
                width: null,
                onPressed: onRetry,
                icon: SvgIcon(
                  UiSvgIcons.refreshArrow,
                  size: 20,
                  color: theme.accent,
                ),
              ),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _FailureWidgetSmall extends FailureWidget {
  const _FailureWidgetSmall({
    required super.exception,
    this.textColor,
    super.onRetry,
    super.key,
  }) : super._();

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final uiModel = ExceptionUiMapper(context).map(exception);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                uiModel.description,
                style: textStyles.regularBody14.copyWith(
                  color: textColor ?? theme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (uiModel.canRetry && onRetry != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onRetry,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgIcon(
                    UiSvgIcons.refreshArrow,
                    size: 20,
                    color: textColor ?? theme.accent,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
