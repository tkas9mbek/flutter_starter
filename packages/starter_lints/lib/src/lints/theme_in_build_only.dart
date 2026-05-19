import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Ensures theme is only accessed in build(), never stored in state fields
/// or passed as constructor parameters.
class ThemeInBuildOnly extends DartLintRule {
  const ThemeInBuildOnly() : super(code: _fieldCode);

  static const _fieldCode = LintCode(
    name: 'theme_in_build_only',
    problemMessage:
        'Do not store theme in state fields. '
        'Get theme in build() as a local variable.',
    correctionMessage: 'Move ThemeProvider.of(context) into build().',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _paramCode = LintCode(
    name: 'theme_in_build_only',
    problemMessage:
        'Do not pass theme as constructor parameter. '
        'Each widget should get theme from context.',
    correctionMessage:
        'Remove theme parameter and use ThemeProvider.of(context) in build().',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _themeTypes = {'AppTheme', 'AppTextStyles', 'ThemeData'};

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.source.uri.path;

    // Skip theme infrastructure files — they must store theme types
    if (path.contains('/theme/')) {
      return;
    }

    context.registry.addFieldDeclaration((node) {
      if (node.isStatic) {
        return;
      }

      final type = node.fields.type;

      if (type == null) {
        return;
      }

      final typeName = type.toSource().replaceAll('?', '');

      if (_themeTypes.contains(typeName)) {
        reporter.atNode(node, _fieldCode);
      }
    });

    context.registry.addConstructorDeclaration((node) {
      for (final param in node.parameters.parameters) {
        String? typeName;

        if (param is SimpleFormalParameter) {
          typeName = param.type?.toSource().replaceAll('?', '');
        } else if (param is DefaultFormalParameter) {
          final normalParam = param.parameter;

          if (normalParam is SimpleFormalParameter) {
            typeName = normalParam.type?.toSource().replaceAll('?', '');
          }
        }

        if (typeName != null && _themeTypes.contains(typeName)) {
          reporter.atNode(param, _paramCode);
        }
      }
    });
  }
}
