import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

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
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              uiModel.description,
              style: textStyles.regularBody14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (uiModel.canRetry && onRetry != null) ...[
              const SizedBox(height: 8),
              Text(
                UikitLocalizer.of(context).tryRefreshPage,
                style: textStyles.regularBody14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onRetry,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      UiSvgIcons.refreshArrow,
                      package: UiConsts.package,
                      colorFilter: ColorFilter.mode(
                        theme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      UikitLocalizer.of(context).retry,
                      style: textStyles.regularBody14.copyWith(
                        color: theme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
            Text(
              uiModel.description,
              style: textStyles.regularBody14.copyWith(
                color: textColor ?? theme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (uiModel.canRetry && onRetry != null) ...[
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onRetry,
                  child: SvgPicture.asset(
                    UiSvgIcons.refreshArrow,
                    package: UiConsts.package,
                    colorFilter: ColorFilter.mode(
                      textColor ?? theme.textPrimary,
                      BlendMode.srcIn,
                    ),
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
