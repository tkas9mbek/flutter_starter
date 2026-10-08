import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Selectable, horizontally scrollable monospace block that shows [data]
/// pretty-printed.
class RequestLogJsonView extends StatelessWidget {
  const RequestLogJsonView({required this.data, super.key});

  static const _emptyPlaceholder = '—';

  final dynamic data;

  /// Pretty-prints [data] as indented JSON, falling back to its `toString()`
  /// when the value is not JSON-serializable.
  static String prettyPrint(dynamic data) {
    if (data is Map || data is List) {
      try {
        return const JsonEncoder.withIndent('  ').convert(data);
      } catch (_) {
        return data.toString();
      }
    }

    return data?.toString() ?? _emptyPlaceholder;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SelectableText(
        prettyPrint(data),
        style: TextStyle(
          fontFamily: 'monospace',
          fontFamilyFallback: const ['Menlo', 'Courier'],
          fontSize: textStyles.regularBody12.fontSize,
          height: textStyles.regularBody12.height,
          color: theme.textPrimary,
        ),
      ),
    );
  }
}
