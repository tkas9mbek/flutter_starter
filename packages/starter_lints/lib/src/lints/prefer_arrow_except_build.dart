// ignore_for_file: class_size_warning — single lint visitor; splitting hurts rule readability

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
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
    errorSeverity: DiagnosticSeverity.INFO,
  );

  static const _buildMethodCode = LintCode(
    name: 'prefer_arrow_except_build',
    problemMessage: 'build() method must use block body, not arrow.',
    correctionMessage: 'Replace => with { return ...; } for build method.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
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

    context.registry.addFunctionExpression((node) {
      final body = node.body;

      if (body is BlockFunctionBody) {
        final statements = body.block.statements;

        if (statements.length == 1 && statements.first is ReturnStatement) {
          final returnStmt = statements.first as ReturnStatement;

          if (returnStmt.expression != null &&
              !_containsNestedCallback(returnStmt.expression!)) {
            // A method-declaration parent could be build(), which is handled above and must stay block-bodied.
            if (node.parent is! MethodDeclaration) {
              reporter.atNode(node, _defaultCode);
            }
          }
        }

        if (statements.length == 1 && statements.first is ExpressionStatement) {
          final exprStmt = statements.first as ExpressionStatement;

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

      if (expression.target != null) {
        return _containsNestedCallback(expression.target!);
      }
    }

    return false;
  }
}
