import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Detects naming anti-patterns: "Impl" suffix, "Module" in names,
/// "Model" suffix.
class AvoidNamingAntipatterns extends DartLintRule {
  const AvoidNamingAntipatterns() : super(code: _implCode);

  static const _implCode = LintCode(
    name: 'avoid_naming_antipatterns',
    problemMessage: 'Avoid "Impl" suffix. Use concrete naming instead.',
    correctionMessage: 'Rename: TaskDataSourceImpl → RemoteTaskDataSource.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _moduleCode = LintCode(
    name: 'avoid_naming_antipatterns',
    problemMessage: 'Avoid "Module" in class names.',
    correctionMessage: 'Rename: ModuleRepository → FeatureRepository.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _modelCode = LintCode(
    name: 'avoid_naming_antipatterns',
    problemMessage: 'Avoid "Model" suffix in data model classes.',
    correctionMessage: 'Rename: PaymentCategoryModel → PaymentCategory.',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final name = node.name.lexeme;

      if (name.endsWith('Impl')) {
        reporter.atNode(node, _implCode);
      }

      if (name.startsWith('Module') || name.contains('Module')) {
        if (name.endsWith('Repository') ||
            name.endsWith('DataSource') ||
            name.endsWith('Bloc') ||
            name.endsWith('Service')) {
          reporter.atNode(node, _moduleCode);
        }
      }

      if (name.endsWith('Model') && !name.endsWith('UiModel')) {
        final path = resolver.source.uri.path;

        if (path.contains('/model/') || path.contains('/models/')) {
          reporter.atNode(node, _modelCode);
        }
      }
    });
  }
}
