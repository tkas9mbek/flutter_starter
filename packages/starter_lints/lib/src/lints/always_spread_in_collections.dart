import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that enforces spread operator after if/for in collections.
///
/// Always use `if (cond) ...[Widget()]` instead of `if (cond) Widget()`.
class AlwaysSpreadInCollections extends DartLintRule {
  const AlwaysSpreadInCollections() : super(code: _code);

  static const _code = LintCode(
    name: 'always_spread_in_collections',
    problemMessage:
        'Use spread operator with if/for in collections: if (cond) ...[Widget()]',
    correctionMessage: 'Wrap the element in a spread: if (cond) ...[element]',
    errorSeverity: DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addListLiteral((node) {
      for (final element in node.elements) {
        _checkElement(element, reporter);
      }
    });
  }

  void _checkElement(CollectionElement element, DiagnosticReporter reporter) {
    if (element is IfElement) {
      final thenElement = element.thenElement;

      if (thenElement is! SpreadElement) {
        reporter.atNode(element, _code);
      }

      final elseElement = element.elseElement;

      if (elseElement != null && elseElement is! SpreadElement) {
        // else-if chains (an IfElement else) are allowed; only a bare non-spread else is flagged.
        if (elseElement is! IfElement) {
          reporter.atNode(element, _code);
        }
      }
    }

    if (element is ForElement) {
      final body = element.body;

      if (body is! SpreadElement) {
        reporter.atNode(element, _code);
      }
    }
  }
}
