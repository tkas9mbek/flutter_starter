import 'package:flutter/material.dart';
import 'package:flutter_starter/core/data/exceptions/app_exception.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/resources/resources.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/button/app_base_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailureWidgetLarge extends StatelessWidget {
  final AppException exception;
  final VoidCallback? onRetry;

  const FailureWidgetLarge({
    required this.exception,
    this.onRetry,
    Key? key,
  }) : super(key: key);

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
            const Spacer(),
            Text(
              exception.getDescription(context),
              style: textStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (exception.canRefresh && onRetry != null) ...[
              const SizedBox(height: 8),
              Text(
                S.of(context).tryRefreshPage,
                style: textStyles.bodyMedium,
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
                      SvgIcons.refresh,
                      colorFilter: ColorFilter.mode(
                        theme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).retry,
                      style: textStyles.bodyLarge.copyWith(
                        color: theme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class FailureWidgetMedium extends StatelessWidget {
  const FailureWidgetMedium({
    required this.exception,
    this.onRetry,
    Key? key,
  }) : super(key: key);

  final AppException exception;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Text(
            exception.getDescription(context),
            textAlign: TextAlign.center,
            style: textStyles.titleLarge,
          ),
          if (exception.canRefresh && onRetry != null) ...[
            const SizedBox(height: 8),
            Text(
              S.of(context).tryRefreshPage,
              style: textStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppBaseButton(
                    backgroundColor: theme.surface,
                    textColor: theme.onSurface,
                    text: S.of(context).retry,
                    onPressed: onRetry,
                    icon: SvgPicture.asset(
                      SvgIcons.refresh,
                      colorFilter: ColorFilter.mode(
                        theme.onBackground,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class FailureWidgetSmall extends StatelessWidget {
  final AppException exception;
  final VoidCallback? onRetry;
  final Color? textColor;

  const FailureWidgetSmall({
    required this.exception,
    this.onRetry,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exception.getDescription(context),
              style: textStyles.bodyLarge.copyWith(
                color: textColor ?? theme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            if (exception.canRefresh && onRetry != null) ...[
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onRetry,
                  child: SvgPicture.asset(
                    SvgIcons.refresh,
                    colorFilter: ColorFilter.mode(
                      textColor ?? theme.onBackground,
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
