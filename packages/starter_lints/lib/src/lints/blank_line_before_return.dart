import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that requires a blank line before return statements.
///
/// Improves readability by visually separating the return from logic above.
class BlankLineBeforeReturn extends DartLintRule {
  const BlankLineBeforeReturn() : super(code: _code);

  static const _code = LintCode(
    name: 'blank_line_before_return',
    problemMessage: 'Add a blank line before return statement.',
    correctionMessage: 'Insert an empty line before the return.',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addReturnStatement((node) {
      final parent = node.parent;

      if (parent is! Block) {
        return;
      }

      final statements = parent.statements;
      final index = statements.indexOf(node);

      // Skip if first statement in block
      if (index <= 0) {
        return;
      }

      final previousStatement = statements[index - 1];

      // Get line info
      final unit = node.root as CompilationUnit;
      final lineInfo = unit.lineInfo;

      final returnLine = lineInfo.getLocation(node.offset).lineNumber;
      final previousEndLine = lineInfo
          .getLocation(previousStatement.end)
          .lineNumber;

      // Check if there's a blank line between them
      final linesDiff = returnLine - previousEndLine;

      if (linesDiff < 2) {
        // Less than 2 means no blank line (1 = consecutive lines)
        reporter.atNode(node, _code);
      }
    });
  }
}
