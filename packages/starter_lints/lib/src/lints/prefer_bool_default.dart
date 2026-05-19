import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that suggests a default value instead of nullable booleans.
///
/// `bool?` parameters force every caller and every consumer to handle
/// three states (true / false / null). Pick a sensible default and use
/// a non-nullable `bool` instead. If `null` carries semantic meaning,
/// model it as an enum.
class PreferBoolDefault extends DartLintRule {
  const PreferBoolDefault() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_bool_default',
    problemMessage:
        'Avoid nullable bool parameters. Use a non-nullable bool with a '
        'default value.',
    correctionMessage:
        'Change the type to bool and provide a default value, or model '
        'the third state as an enum.',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFunctionDeclaration(
      (node) => _checkParameters(node.functionExpression.parameters, reporter),
    );

    context.registry.addMethodDeclaration((node) {
      final hasOverride = node.metadata.any(
        (annotation) => annotation.name.name == 'override',
      );

      if (hasOverride) {
        return;
      }

      _checkParameters(node.parameters, reporter);
    });

    context.registry.addConstructorDeclaration(
      (node) => _checkParameters(node.parameters, reporter),
    );
  }

  void _checkParameters(
    FormalParameterList? parameters,
    ErrorReporter reporter,
  ) {
    if (parameters == null) {
      return;
    }

    for (final param in parameters.parameters) {
      if (_isNullableBool(param)) {
        reporter.atNode(param, _code);
      }
    }
  }

  bool _isNullableBool(FormalParameter param) {
    final inner = param is DefaultFormalParameter ? param.parameter : param;

    TypeAnnotation? type;

    if (inner is SimpleFormalParameter) {
      type = inner.type;
    } else if (inner is FieldFormalParameter) {
      type = inner.type;
    } else if (inner is SuperFormalParameter) {
      type = inner.type;
    }

    if (type == null) {
      return false;
    }

    return type.toSource() == 'bool?';
  }
}
