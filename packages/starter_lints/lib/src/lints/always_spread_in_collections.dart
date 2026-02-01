import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that enforces spread operator after if/for in collections.
///
/// Always use `if (cond) ...[Widget()]` instead of `if (cond) Widget()`.
/// This improves consistency and makes conditionals more visible.
class AlwaysSpreadInCollections extends DartLintRule {
  const AlwaysSpreadInCollections() : super(code: _code);

  static const _code = LintCode(
    name: 'always_spread_in_collections',
    problemMessage:
        'Use spread operator with if/for in collections: if (cond) ...[Widget()]',
    correctionMessage: 'Wrap the element in a spread: if (cond) ...[element]',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addListLiteral((node) {
      for (final element in node.elements) {
        _checkElement(element, reporter);
      }
    });
  }

  void _checkElement(CollectionElement element, ErrorReporter reporter) {
    if (element is IfElement) {
      // Check if the then element is NOT a spread
      final thenElement = element.thenElement;

      if (thenElement is! SpreadElement) {
        reporter.atNode(element, _code);
      }

      // Also check else element if present
      final elseElement = element.elseElement;

      if (elseElement != null && elseElement is! SpreadElement) {
        // Only report if there's a non-spread else
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
