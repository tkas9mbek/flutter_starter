import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Warns against long ternary expressions.
///
/// - Single condition: > 10 lines → use if/else with early return.
/// - Nested (2+ conditions): >= 5 lines → use if/else with early return.
class MultiLineTernary extends DartLintRule {
  const MultiLineTernary() : super(code: _code);

  static const _code = LintCode(
    name: 'multi_line_ternary',
    problemMessage:
        'Ternary expression is too long. Use if/else with early return.',
    correctionMessage: 'Replace with if/else block for readability.',
    errorSeverity: DiagnosticSeverity.INFO,
  );

  static const _maxLinesSingle = 10;
  static const _maxLinesNested = 5;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addConditionalExpression((node) {
      // Skip nested ternaries — only report on the outermost one.
      if (node.parent is ConditionalExpression) {
        return;
      }

      final unit = node.root as CompilationUnit;
      final lineInfo = unit.lineInfo;

      final startLine = lineInfo.getLocation(node.offset).lineNumber;
      final endLine = lineInfo.getLocation(node.end).lineNumber;
      final lineCount = endLine - startLine + 1;

      final hasNestedTernary =
          node.thenExpression is ConditionalExpression ||
          node.elseExpression is ConditionalExpression;

      final maxLines = hasNestedTernary ? _maxLinesNested : _maxLinesSingle;

      if (hasNestedTernary ? lineCount >= maxLines : lineCount > maxLines) {
        reporter.atNode(node, _code);
      }
    });
  }
}
