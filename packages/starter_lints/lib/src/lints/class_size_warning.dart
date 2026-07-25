import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Warns when a class exceeds 100 lines.
///
/// This is a guideline, not a hard rule — some classes may legitimately
/// exceed this threshold.
class ClassSizeWarning extends DartLintRule {
  const ClassSizeWarning() : super(code: _code);

  static const _code = LintCode(
    name: 'class_size_warning',
    problemMessage: 'Class exceeds 100 lines. Consider splitting for SRP.',
    correctionMessage:
        'Check if the class has multiple responsibilities that can be extracted.',
    errorSeverity: DiagnosticSeverity.INFO,
  );

  static const _maxLines = 100;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.source.uri.path;

    if (path.endsWith('.g.dart') ||
        path.endsWith('.freezed.dart') ||
        path.endsWith('.config.dart') ||
        path.contains('/example/') ||
        path.contains('/external/') ||
        path.contains('/l10n/')) {
      return;
    }

    context.registry.addClassDeclaration((node) {
      final unit = node.root as CompilationUnit;
      final lineInfo = unit.lineInfo;

      final startLine = lineInfo.getLocation(node.offset).lineNumber;
      final endLine = lineInfo.getLocation(node.end).lineNumber;
      final lineCount = endLine - startLine + 1;

      if (lineCount > _maxLines) {
        reporter.atNode(node, _code);
      }
    });
  }
}
