import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule forbidding hardcoded `Color(...)` and `Colors.X` references
/// outside theme/constants directories.
///
/// All colors should flow through `ThemeProvider` so the app respects
/// light/dark themes and the design-system tokens. Theme files
/// themselves and color constants in `**/constants/**` are exempt.
class NoHardcodedColors extends DartLintRule {
  const NoHardcodedColors() : super(code: _code);

  static const _code = LintCode(
    name: 'no_hardcoded_colors',
    problemMessage:
        'Hardcoded color values are not allowed outside theme/constants.',
    correctionMessage:
        'Use ThemeProvider.of(context).theme or a token from the design '
        'system instead.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _allowedPathSegments = <String>[
    '/theme/',
    '/constants/',
    '/tokens/',
    '/converters/',
  ];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.path.replaceAll(r'\', '/');

    final isAllowed = _allowedPathSegments.any(path.contains);

    if (isAllowed) {
      return;
    }

    context.registry.addInstanceCreationExpression((node) {
      final typeName = node.constructorName.type.qualifiedName;

      if (_isColorType(typeName)) {
        reporter.atNode(node, _code);
      }
    });

    context.registry.addPrefixedIdentifier((node) {
      final prefix = node.prefix.name;

      if (prefix == 'Colors') {
        reporter.atNode(node, _code);
      }
    });
  }

  bool _isColorType(String typeName) {
    return typeName == 'Color' ||
        typeName == 'ColorSwatch' ||
        typeName.endsWith('.Color') ||
        typeName.endsWith('.ColorSwatch');
  }
}

extension on NamedType {
  String get qualifiedName {
    final importPrefix = this.importPrefix?.name.lexeme;
    final name = name2.lexeme;

    return importPrefix == null ? name : '$importPrefix.$name';
  }
}
