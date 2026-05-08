import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule requiring braces in flow-control statements.
///
/// - `for`, `while`, `do-while`: braces are always required.
/// - `if` / `else`: braces are required when the body lives on a different
///   line than the keyword. A single-line `if (cond) doIt();` is allowed.
class BracesInFlowControl extends DartLintRule {
  const BracesInFlowControl() : super(code: _code);

  static const _code = LintCode(
    name: 'braces_in_flow_control',
    problemMessage: 'Flow-control statements should use braces.',
    correctionMessage: 'Wrap the body in `{ ... }`.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addForStatement((node) {
      _check(node.body, node.offset, node.root, reporter);
    });

    context.registry.addWhileStatement((node) {
      _check(node.body, node.offset, node.root, reporter);
    });

    context.registry.addDoStatement((node) {
      _check(node.body, node.offset, node.root, reporter);
    });

    context.registry.addIfStatement((node) {
      _checkIf(node, reporter);
    });
  }

  void _check(
    Statement body,
    int keywordOffset,
    AstNode root,
    ErrorReporter reporter,
  ) {
    if (body is Block) {
      return;
    }

    reporter.atNode(body, _code);
  }

  void _checkIf(IfStatement node, ErrorReporter reporter) {
    final unit = node.root as CompilationUnit;
    final lineInfo = unit.lineInfo;

    final ifLine = lineInfo.getLocation(node.offset).lineNumber;
    final thenStatement = node.thenStatement;

    if (thenStatement is! Block) {
      final thenLine = lineInfo.getLocation(thenStatement.offset).lineNumber;

      if (thenLine != ifLine) {
        reporter.atNode(thenStatement, _code);
      }
    }

    final elseStatement = node.elseStatement;

    if (elseStatement != null &&
        elseStatement is! Block &&
        elseStatement is! IfStatement) {
      reporter.atNode(elseStatement, _code);
    }
  }
}
