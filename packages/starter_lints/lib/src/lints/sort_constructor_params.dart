import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that enforces constructor parameter ordering:
/// 1. Required parameters
/// 2. Parameters with defaults
/// 3. Optional parameters (nullable without default)
/// 4. Super parameters (super.key)
class SortConstructorParams extends DartLintRule {
  const SortConstructorParams() : super(code: _code);

  static const _code = LintCode(
    name: 'sort_constructor_params',
    problemMessage:
        'Constructor parameters should be ordered: required → defaults → optional → super.',
    correctionMessage:
        'Reorder parameters: required first, then defaults, optional, super.key last.',
    errorSeverity: DiagnosticSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addConstructorDeclaration((node) {
      final parameters = node.parameters.parameters;

      if (parameters.length < 2) {
        return;
      }

      final namedParams = parameters.where((p) => p.isNamed).toList();

      if (namedParams.length < 2) {
        return;
      }

      if (!_isCorrectlyOrdered(namedParams)) {
        reporter.atNode(node.parameters, _code);
      }
    });
  }

  bool _isCorrectlyOrdered(List<FormalParameter> params) {
    var currentCategory = _ParamCategory.required;

    for (final param in params) {
      final category = _getCategory(param);

      if (category.index < currentCategory.index) {
        return false;
      }

      currentCategory = category;
    }

    return true;
  }

  _ParamCategory _getCategory(FormalParameter param) {
    // Required super params (required super.child) count as required: the core
    // always_put_required_named_parameters_first lint forces them to the front.
    if (param is SuperFormalParameter) {
      return param.isRequired
          ? _ParamCategory.required
          : _ParamCategory.superParam;
    }

    if (param is DefaultFormalParameter) {
      final normalParam = param.parameter;

      if (normalParam is SuperFormalParameter) {
        return param.isRequired
            ? _ParamCategory.required
            : _ParamCategory.superParam;
      }

      if (param.defaultValue != null) {
        return _ParamCategory.withDefault;
      }

      if (param.isRequired) {
        return _ParamCategory.required;
      }

      return _ParamCategory.optional;
    }

    return _ParamCategory.required;
  }
}

enum _ParamCategory {
  required, // required this.x
  withDefault, // this.x = value
  optional, // this.x (nullable, no default)
  superParam, // super.key
}
