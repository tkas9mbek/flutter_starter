import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that flags `maybeMap`/`maybeWhen` calls whose `orElse`
/// is empty.
///
/// When the only purpose of `orElse` is "do nothing", `mapOrNull` /
/// `whenOrNull` express that intent more clearly and remove the dead
/// `() {}` closure.
class PreferMapOrNull extends DartLintRule {
  const PreferMapOrNull() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_map_or_null',
    problemMessage:
        'Use mapOrNull / whenOrNull instead of maybeMap / maybeWhen with '
        'an empty orElse.',
    correctionMessage:
        'Replace maybeMap with mapOrNull (or maybeWhen with whenOrNull) '
        'and remove the empty orElse argument.',
    errorSeverity: ErrorSeverity.INFO,
  );

  static const _targetMethodNames = <String>{'maybeMap', 'maybeWhen'};

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      final methodName = node.methodName.name;

      if (!_targetMethodNames.contains(methodName)) {
        return;
      }

      final orElseArg = _findNamedArgument(node.argumentList, 'orElse');

      if (orElseArg == null) {
        return;
      }

      if (_isEmptyClosure(orElseArg.expression)) {
        reporter.atNode(node, _code);
      }
    });
  }

  NamedExpression? _findNamedArgument(ArgumentList list, String name) {
    for (final arg in list.arguments) {
      if (arg is NamedExpression && arg.name.label.name == name) {
        return arg;
      }
    }

    return null;
  }

  bool _isEmptyClosure(Expression expression) {
    if (expression is! FunctionExpression) {
      return false;
    }

    final body = expression.body;

    if (body is BlockFunctionBody) {
      return body.block.statements.isEmpty;
    }

    if (body is ExpressionFunctionBody) {
      final inner = body.expression;

      return inner is NullLiteral;
    }

    return false;
  }
}
