import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule forbidding mutable instance fields on BLoC and Cubit subclasses.
///
/// All mutable data must live in the Freezed state — instance fields on
/// the BLoC class itself bypass state emission and silently desync the UI.
/// Subscriptions and timers are exempt because they are infrastructure,
/// not state.
class AvoidMutableBlocFields extends DartLintRule {
  const AvoidMutableBlocFields() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_mutable_bloc_fields',
    problemMessage:
        'BLoC and Cubit classes must not have mutable instance fields.',
    correctionMessage:
        'Move mutable data into the Freezed state class. Mark this field '
        'final, or expose it through a state property.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  static const _exemptTypeSuffixes = <String>[
    'StreamSubscription',
    'Timer',
    'CancelToken',
    'Completer',
  ];

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final extendsClause = node.extendsClause;

      if (extendsClause == null) {
        return;
      }

      final superclassName = extendsClause.superclass.name.lexeme;

      if (superclassName != 'Bloc' && superclassName != 'Cubit') {
        return;
      }

      for (final member in node.members) {
        if (member is! FieldDeclaration || member.isStatic) {
          continue;
        }

        final fields = member.fields;

        if (fields.isFinal || fields.isConst) {
          continue;
        }

        final typeName = fields.type?.toSource() ?? '';

        if (_isExemptType(typeName)) {
          continue;
        }

        reporter.atNode(member, _code);
      }
    });
  }

  bool _isExemptType(String typeName) {
    final stripped = typeName.replaceAll('?', '').trim();

    return _exemptTypeSuffixes.any(
      (suffix) =>
          stripped == suffix ||
          stripped.startsWith('$suffix<') ||
          stripped.endsWith('.$suffix'),
    );
  }
}
