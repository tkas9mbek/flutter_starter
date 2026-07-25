import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';

/// Flag and dial-code prefix for phone inputs; tapping opens a bottom sheet
/// listing [countries] and reports the picked one via [onChanged].
class CountryCodeField extends StatelessWidget {
  const CountryCodeField({
    required this.countries,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<CountryCode> countries;
  final CountryCode selected;
  final ValueChanged<CountryCode> onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await BottomSheetScreen.show<CountryCode>(
      context: context,
      builder: (context) =>
          _CountryCodeSheet(countries: countries, selected: selected),
    );

    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _pick(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(selected.flag, style: textStyles.regularBody16),
          const SizedBox(width: 5),
          Text(
            selected.dialCode,
            style: textStyles.regularBody16.copyWith(color: theme.textPrimary),
          ),
          const SizedBox(width: 10),
          VerticalDivider(width: 1, color: theme.border),
        ],
      ),
    );
  }
}

class _CountryCodeSheet extends StatelessWidget {
  const _CountryCodeSheet({required this.countries, required this.selected});

  final List<CountryCode> countries;
  final CountryCode selected;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return BottomSheetScreen(
      showCloseButton: false,
      bgColor: theme.surface,
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CountryRow(
            country: selected,
            isSelected: true,
            onTap: () => Navigator.pop(context, selected),
          ),
          const SizedBox(height: 20),
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.surfaceMuted,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                for (final country in countries) ...[
                  _CountryRow(
                    country: country,
                    hasDivider: country != countries.last,
                    onTap: () => Navigator.pop(context, country),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryRow extends StatelessWidget {
  const _CountryRow({
    required this.country,
    required this.onTap,
    this.isSelected = false,
    this.hasDivider = false,
  });

  final CountryCode country;
  final VoidCallback onTap;
  final bool isSelected;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? theme.primary.withValues(alpha: 0.5) : null,
          borderRadius: isSelected ? BorderRadius.circular(18) : null,
          border: hasDivider
              ? Border(bottom: BorderSide(color: theme.border))
              : null,
        ),
        child: Row(
          children: [
            Text(country.flag, style: textStyles.regularBody16),
            const SizedBox(width: 14),
            Text(
              '${country.name}  ${country.dialCode}',
              style: isSelected
                  ? textStyles.boldBody16
                  : textStyles.regularBody16,
            ),
          ],
        ),
      ),
    );
  }
}
