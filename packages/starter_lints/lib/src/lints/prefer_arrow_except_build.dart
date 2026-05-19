import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that enforces arrow syntax usage:
/// - Always use arrow `=>` for callbacks and single expressions
/// - EXCEPT: `build()` method must use block body `{}`
/// - Nested callbacks (setState, then, etc.) can use either style
class PreferArrowExceptBuild extends DartLintRule {
  const PreferArrowExceptBuild() : super(code: _defaultCode);

  static const _defaultCode = LintCode(
    name: 'prefer_arrow_except_build',
    problemMessage: 'Use arrow syntax for single-expression callbacks.',
    correctionMessage: 'Replace block body with => for single expressions.',
    errorSeverity: ErrorSeverity.INFO,
  );

  static const _buildMethodCode = LintCode(
    name: 'prefer_arrow_except_build',
    problemMessage: 'build() method must use block body, not arrow.',
    correctionMessage: 'Replace => with { return ...; } for build method.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Check build() method - must NOT use arrow
    context.registry.addMethodDeclaration((node) {
      if (node.name.lexeme != 'build') {
        return;
      }

      final hasOverride = node.metadata.any(
        (annotation) => annotation.name.name == 'override',
      );

      if (!hasOverride) {
        return;
      }

      if (node.body is ExpressionFunctionBody) {
        reporter.atNode(node, _buildMethodCode);
      }
    });

    // Check function expressions (callbacks)
    context.registry.addFunctionExpression((node) {
      final body = node.body;

      // Check for block body that could be arrow - should use arrow
      if (body is BlockFunctionBody) {
        final statements = body.block.statements;

        // Single return statement could be arrow
        if (statements.length == 1 && statements.first is ReturnStatement) {
          final returnStmt = statements.first as ReturnStatement;

          // Skip if the return expression contains nested callbacks
          if (returnStmt.expression != null &&
              !_containsNestedCallback(returnStmt.expression!)) {
            // Skip if parent is a method declaration (could be build method)
            if (node.parent is! MethodDeclaration) {
              reporter.atNode(node, _defaultCode);
            }
          }
        }

        // Single expression statement could be arrow (for void callbacks)
        if (statements.length == 1 && statements.first is ExpressionStatement) {
          final exprStmt = statements.first as ExpressionStatement;

          // Skip if contains setState or similar nested callbacks
          if (!_containsNestedCallback(exprStmt.expression)) {
            reporter.atNode(node, _defaultCode);
          }
        }
      }
    });
  }

  bool _isNestedCallbackMethod(String methodName) {
    return const {
      'setState',
      'then',
      'whenComplete',
      'catchError',
      'onError',
    }.contains(methodName);
  }

  bool _containsNestedCallback(Expression expression) {
    if (expression is MethodInvocation) {
      final methodName = expression.methodName.name;

      if (_isNestedCallbackMethod(methodName)) {
        return expression.argumentList.arguments.any(
          (arg) => arg is FunctionExpression,
        );
      }

      // Recursively check chained calls
      if (expression.target != null) {
        return _containsNestedCallback(expression.target!);
      }
    }

    return false;
  }
}
