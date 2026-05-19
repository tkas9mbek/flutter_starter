import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Enforces correct Freezed method usage in BlocListener vs BlocBuilder.
///
/// - BlocListener: use whenOrNull/mapOrNull (no empty orElse)
/// - BlocBuilder: use maybeMap/maybeWhen (returns widget with orElse)
class BlocListenerBuilderUsage extends DartLintRule {
  const BlocListenerBuilderUsage() : super(code: _listenerCode);

  static const _listenerCode = LintCode(
    name: 'bloc_listener_builder_usage',
    problemMessage:
        'BlocListener should use whenOrNull/mapOrNull, not maybeWhen/maybeMap.',
    correctionMessage:
        'Replace maybeWhen/maybeMap with whenOrNull/mapOrNull in BlocListener.',
    errorSeverity: ErrorSeverity.INFO,
  );

  static const _builderCode = LintCode(
    name: 'bloc_listener_builder_usage',
    problemMessage:
        'BlocBuilder should use maybeMap/maybeWhen, not mapOrNull/whenOrNull.',
    correctionMessage:
        'Replace mapOrNull/whenOrNull with maybeMap/maybeWhen in BlocBuilder.',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final typeName = node.constructorName.type.name2.lexeme;

      if (typeName == 'BlocListener' || typeName.startsWith('BlocListener<')) {
        _checkListener(node, reporter);
      }

      if (typeName == 'BlocBuilder' || typeName.startsWith('BlocBuilder<')) {
        _checkBuilder(node, reporter);
      }
    });
  }

  void _checkListener(InstanceCreationExpression node, ErrorReporter reporter) {
    final listenerArg = node.argumentList.arguments
        .whereType<NamedExpression>()
        .where((arg) => arg.name.label.name == 'listener');

    if (listenerArg.isEmpty) {
      return;
    }

    _findMethodCalls(listenerArg.first.expression, (methodName, methodNode) {
      if (methodName == 'maybeWhen' || methodName == 'maybeMap') {
        reporter.atNode(methodNode, _listenerCode);
      }
    });
  }

  void _checkBuilder(InstanceCreationExpression node, ErrorReporter reporter) {
    final builderArg = node.argumentList.arguments
        .whereType<NamedExpression>()
        .where((arg) => arg.name.label.name == 'builder');

    if (builderArg.isEmpty) {
      return;
    }

    _findMethodCalls(builderArg.first.expression, (methodName, methodNode) {
      if (methodName == 'mapOrNull' || methodName == 'whenOrNull') {
        reporter.atNode(methodNode, _builderCode);
      }
    });
  }

  void _findMethodCalls(
    Expression? expression,
    void Function(String name, MethodInvocation node) callback,
  ) {
    if (expression == null) {
      return;
    }

    if (expression is FunctionExpression) {
      final body = expression.body;

      if (body is BlockFunctionBody) {
        for (final statement in body.block.statements) {
          _visitStatement(statement, callback);
        }
      }

      if (body is ExpressionFunctionBody) {
        _visitExpression(body.expression, callback);
      }
    }
  }

  void _visitStatement(
    Statement statement,
    void Function(String, MethodInvocation) callback,
  ) {
    if (statement is ExpressionStatement) {
      _visitExpression(statement.expression, callback);
    }

    if (statement is ReturnStatement && statement.expression != null) {
      _visitExpression(statement.expression!, callback);
    }
  }

  void _visitExpression(
    Expression expression,
    void Function(String, MethodInvocation) callback,
  ) {
    if (expression is MethodInvocation) {
      callback(expression.methodName.name, expression);

      if (expression.target != null) {
        _visitExpression(expression.target!, callback);
      }
    }
  }
}
