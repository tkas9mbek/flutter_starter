import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that warns against BLoC depending on another BLoC.
///
/// BLoCs should be independent. Use UI layer (MultiBlocListener) to
/// coordinate between BLoCs instead of injecting one BLoC into another.
class BlocNoBlocDependency extends DartLintRule {
  const BlocNoBlocDependency() : super(code: _code);

  static const _code = LintCode(
    name: 'bloc_no_bloc_dependency',
    problemMessage:
        'BLoCs should not depend on other BLoCs. Use UI layer for coordination.',
    correctionMessage:
        'Remove BLoC dependency and use MultiBlocListener in UI instead.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      // Check if this class extends Bloc or Cubit
      final extendsClause = node.extendsClause;

      if (extendsClause == null) {
        return;
      }

      final superclassName = extendsClause.superclass.name2.lexeme;

      if (superclassName != 'Bloc' && superclassName != 'Cubit') {
        return;
      }

      // Check constructor parameters and fields for BLoC dependencies
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          _checkField(member, reporter);
        }

        if (member is ConstructorDeclaration) {
          _checkConstructor(member, reporter);
        }
      }
    });
  }

  void _checkField(FieldDeclaration field, ErrorReporter reporter) {
    final type = field.fields.type;

    if (type == null) {
      return;
    }

    final typeName = type.toSource();

    if (_isBlocType(typeName)) {
      reporter.atNode(field, _code);
    }
  }

  void _checkConstructor(
    ConstructorDeclaration constructor,
    ErrorReporter reporter,
  ) {
    for (final param in constructor.parameters.parameters) {
      String? typeName;

      if (param is SimpleFormalParameter) {
        typeName = param.type?.toSource();
      } else if (param is FieldFormalParameter) {
        typeName = param.type?.toSource();
      }

      if (typeName != null && _isBlocType(typeName)) {
        reporter.atNode(param, _code);
      }
    }
  }

  bool _isBlocType(String typeName) {
    return typeName.endsWith('Bloc') || typeName.endsWith('Cubit');
  }
}
