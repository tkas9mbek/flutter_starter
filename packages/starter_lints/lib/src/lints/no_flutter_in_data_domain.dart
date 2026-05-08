import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule forbidding Flutter imports inside data and domain layers.
///
/// Architectural rule: only the presentation layer may depend on Flutter.
/// Data and domain layers must remain pure Dart so they can be reused
/// outside Flutter (server, CLI, isolates) and unit-tested without a
/// widget tester.
class NoFlutterInDataDomain extends DartLintRule {
  const NoFlutterInDataDomain() : super(code: _code);

  static const _code = LintCode(
    name: 'no_flutter_in_data_domain',
    problemMessage:
        'Flutter imports are not allowed in data or domain layers.',
    correctionMessage:
        'Move Flutter-dependent code to the presentation layer, or use '
        'package:meta / dart:developer instead.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  static const _forbiddenImportPrefixes = <String>[
    'package:flutter/',
    'dart:ui',
  ];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.path;

    if (!_isDataOrDomainPath(path)) {
      return;
    }

    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue;

      if (uri == null) {
        return;
      }

      final isForbidden = _forbiddenImportPrefixes.any(uri.startsWith);

      if (isForbidden) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isDataOrDomainPath(String path) {
    final normalized = path.replaceAll(r'\', '/');

    return normalized.contains('/data/') || normalized.contains('/domain/');
  }
}
