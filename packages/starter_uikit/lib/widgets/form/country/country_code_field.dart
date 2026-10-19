import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

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
          const SizedBox(width: 6),
          Text(selected.dialCode, style: textStyles.regularBody16),
          const SizedBox(width: 12),
          SizedBox(
            height: 24,
            child: VerticalDivider(width: 1, color: theme.border),
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            selected: true,
            child: _CountryRow(
              country: selected,
              isSelected: true,
              onTap: () => Navigator.pop(context, selected),
            ),
          ),
          const SizedBox(height: 16),
          GroupedRowsCard(
            children: [
              for (final country in countries) ...[
                _CountryRow(
                  country: country,
                  onTap: () => Navigator.pop(context, country),
                ),
              ],
            ],
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
  });

  final CountryCode country;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Text(country.flag, style: textStyles.regularBody16),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  country.name,
                  style: isSelected
                      ? textStyles.mediumBody16
                      : textStyles.regularBody16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                country.dialCode,
                style: textStyles.regularBody14.copyWith(
                  color: isSelected ? theme.accent : theme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
