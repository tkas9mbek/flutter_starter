import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that suggests named parameters for functions with 3+ parameters.
///
/// Named parameters improve readability at call sites.
class PreferNamedParameters extends DartLintRule {
  const PreferNamedParameters() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_named_parameters',
    problemMessage:
        'Consider using named parameters for functions with 3+ parameters.',
    correctionMessage: 'Convert positional parameters to named parameters.',
    errorSeverity: ErrorSeverity.INFO,
  );

  static const _minPositionalParams = 3;

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Check function declarations
    context.registry.addFunctionDeclaration((node) {
      _checkParameters(node.functionExpression.parameters, node, reporter);
    });

    // Check method declarations
    context.registry.addMethodDeclaration((node) {
      // Skip overridden methods (can't change signature)
      final hasOverride = node.metadata.any(
        (annotation) => annotation.name.name == 'override',
      );

      if (hasOverride) {
        return;
      }

      _checkParameters(node.parameters, node, reporter);
    });

    // Check constructor declarations
    context.registry.addConstructorDeclaration((node) {
      _checkParameters(node.parameters, node, reporter);
    });
  }

  void _checkParameters(
    FormalParameterList? parameters,
    AstNode node,
    ErrorReporter reporter,
  ) {
    if (parameters == null) {
      return;
    }

    // Count positional parameters (not named)
    final positionalParams = parameters.parameters.where((param) {
      return param.isPositional && !param.isNamed;
    }).toList();

    if (positionalParams.length >= _minPositionalParams) {
      reporter.atNode(node, _code);
    }
  }
}
