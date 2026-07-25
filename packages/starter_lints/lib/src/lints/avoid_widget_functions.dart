import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that warns against functions returning Widget.
///
/// Functions returning widgets should be extracted to widget classes for
/// better performance, testability, and cleaner code.
class AvoidWidgetFunctions extends DartLintRule {
  const AvoidWidgetFunctions() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_widget_functions',
    problemMessage:
        'Avoid functions that return Widget. Extract to a widget class instead.',
    correctionMessage: 'Create a StatelessWidget or StatefulWidget class.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      final returnType = node.returnType?.type;

      if (returnType == null) {
        return;
      }

      final typeName = returnType.getDisplayString();

      if (_isWidgetType(typeName) && node.name.lexeme.startsWith('_build')) {
        reporter.atNode(node, _code);
      }
    });

    context.registry.addFunctionDeclaration((node) {
      final returnType = node.returnType?.type;

      if (returnType == null) {
        return;
      }

      final typeName = returnType.getDisplayString();

      if (_isWidgetType(typeName) && node.name.lexeme.startsWith('_build')) {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isWidgetType(String typeName) {
    return typeName == 'Widget' ||
        typeName.endsWith('Widget') ||
        typeName == 'PreferredSizeWidget';
  }
}
