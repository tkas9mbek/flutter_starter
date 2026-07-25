import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule forbidding `BuildContext` as a stored field.
///
/// `BuildContext` is bound to a specific element in the widget tree and
/// becomes invalid after rebuilds or unmounts. Storing it as a field
/// invites use-after-dispose bugs. Pass `BuildContext` as a parameter
/// to the methods that need it instead.
class AvoidBuildContextField extends DartLintRule {
  const AvoidBuildContextField() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_build_context_field',
    problemMessage: 'Do not store BuildContext as a field.',
    correctionMessage:
        'Pass BuildContext as a parameter to the methods that need it.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFieldDeclaration((node) {
      final type = node.fields.type;

      if (type == null) {
        return;
      }

      final typeName = type.toSource();

      if (typeName == 'BuildContext' || typeName == 'BuildContext?') {
        reporter.atNode(node, _code);
      }
    });
  }
}
