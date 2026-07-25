import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Warns when widget nesting in build() exceeds 8 levels.
class MaxWidgetNesting extends DartLintRule {
  const MaxWidgetNesting() : super(code: _code);

  static const _code = LintCode(
    name: 'max_widget_nesting',
    problemMessage:
        'Widget nesting exceeds 8 levels. Extract inner widgets into '
        'separate classes.',
    correctionMessage: 'Break the widget tree into smaller widget classes.',
    errorSeverity: DiagnosticSeverity.INFO,
  );

  static const _maxDepth = 8;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      if (node.name.lexeme != 'build') {
        return;
      }

      final hasOverride = node.metadata.any(
        (annotation) => annotation.name.name == 'override',
      );

      if (!hasOverride) {
        return;
      }

      final visitor = _NestingVisitor();
      node.body.accept(visitor);

      if (visitor.maxDepth > _maxDepth) {
        reporter.atNode(node, _code);
      }
    });
  }
}

class _NestingVisitor extends RecursiveAstVisitor<void> {
  int _currentDepth = 0;
  int maxDepth = 0;

  /// Non-widget types that inflate nesting count with false depth.
  static const _skipTypes = {
    'EdgeInsets',
    'EdgeInsetsDirectional',
    'BoxDecoration',
    'BoxShadow',
    'BorderRadius',
    'Border',
    'BorderSide',
    'TextStyle',
    'TextSpan',
    'Duration',
    'Offset',
    'Size',
    'Radius',
    'ColorFilter',
    'ValueKey',
    'ObjectKey',
    'GlobalKey',
    'BoxConstraints',
    'RoundedRectangleBorder',
    'CircleBorder',
    'StadiumBorder',
    'LinearGradient',
    'RadialGradient',
    'Shadow',
    'ShapeDecoration',
    'InputDecoration',
    'OutlineInputBorder',
    'UnderlineInputBorder',
  };

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;

    if (_skipTypes.contains(typeName)) {
      super.visitInstanceCreationExpression(node);

      return;
    }

    _currentDepth++;

    if (_currentDepth > maxDepth) {
      maxDepth = _currentDepth;
    }

    super.visitInstanceCreationExpression(node);
    _currentDepth--;
  }
}
