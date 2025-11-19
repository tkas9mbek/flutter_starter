import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Exception mapper code generator.
///
/// Parses AppException Freezed class and automatically generates:
/// - ExceptionUiMapper methods with localization
/// - ExceptionUiMapperDecorator delegations
///
/// Run this generator after modifying AppException factories:
/// ```bash
/// dart run tool/generate_exception_mapper.dart
/// ```
Future<void> main() async {
  print('🔍 Analyzing AppException...');

  final exceptionFilePath =
      'packages/starter_toolkit/lib/data/exceptions/app_exception.dart';

  final factories = await ExceptionAnalyzer.analyze(exceptionFilePath);
  print('✅ Found ${factories.length} exception factories');

  print('📝 Generating mapper code...');

  final generator = ExceptionUiMapperGenerator(factories);

  await generator.writeToFiles(
    mapperFilePath:
        'packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart',
    decoratorFilePath:
        'packages/starter_uikit/lib/utils/mappers/exception_ui_mapper_decorator.dart',
  );

  print('✅ Code generation complete!');
  print('');
  print('Don\'t forget to run:');
  print('  dart format .');
  print(
      '  fvm flutter pub run build_runner build --delete-conflicting-outputs');
}

/// Parsed exception class information
class ExceptionFactory {
  final String className;
  final List<FactoryParameter> parameters;
  final ExceptionUiConfigData config;
  final bool canRetry;

  ExceptionFactory({
    required this.className,
    required this.parameters,
    required this.config,
    required this.canRetry,
  });

  String get mapperMethodName => 'map${className.replaceAll('Exception', '')}';
}

class FactoryParameter {
  final String name;
  final String type;
  final bool isRequired;

  FactoryParameter({
    required this.name,
    required this.type,
    required this.isRequired,
  });
}

class ExceptionUiConfigData {
  final String? titleKey;
  final String descriptionKey;
  final String? snackbarKey;

  ExceptionUiConfigData({
    this.titleKey,
    required this.descriptionKey,
    this.snackbarKey,
  });
}

/// Analyzes AppException Freezed class
class ExceptionAnalyzer extends SimpleAstVisitor<void> {
  final List<ExceptionFactory> factories = [];

  static Future<List<ExceptionFactory>> analyze(String filePath) async {
    final parseResult = parseFile(
      path: filePath,
      featureSet: FeatureSet.latestLanguageVersion(),
    );

    if (parseResult.errors.isNotEmpty) {
      throw Exception(
        'Parse errors in $filePath:\n${parseResult.errors.join('\n')}',
      );
    }

    final visitor = ExceptionAnalyzer();
    parseResult.unit.visitChildren(visitor);

    return visitor.factories;
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Find sealed exception subclasses (not the base AppException class)
    final extendsClause = node.extendsClause;
    if (extendsClause != null &&
        extendsClause.superclass.name2.toString() == 'AppException') {
      _parseExceptionClass(node);
    }
  }

  void _parseExceptionClass(ClassDeclaration classNode) {
    final className = classNode.name.lexeme;

    final config = _parseAnnotation(classNode);
    if (config == null) return;

    // Find fields (which correspond to constructor parameters)
    final parameters = <FactoryParameter>[];
    for (final member in classNode.members) {
      if (member is FieldDeclaration) {
        for (final variable in member.fields.variables) {
          final fieldName = variable.name.lexeme;
          final fieldType = member.fields.type?.toString() ?? 'dynamic';

          // Skip name and canRetry fields as they are getters
          if (fieldName == 'name' || fieldName == 'canRetry') continue;

          // Determine if required based on nullability
          final isRequired = !fieldType.endsWith('?');

          parameters.add(FactoryParameter(
            name: fieldName,
            type: fieldType,
            isRequired: isRequired,
          ));
        }
      }
    }

    // Find canRetry getter value
    var canRetry = true; // default
    for (final member in classNode.members) {
      if (member is MethodDeclaration &&
          member.isGetter &&
          member.name.lexeme == 'canRetry') {
        final body = member.body;
        if (body is ExpressionFunctionBody) {
          final expression = body.expression;
          if (expression is BooleanLiteral) {
            canRetry = expression.value;
          }
        }
        break;
      }
    }

    factories.add(ExceptionFactory(
      className: className,
      parameters: parameters,
      config: config,
      canRetry: canRetry,
    ));
  }

  ExceptionUiConfigData? _parseAnnotation(ClassDeclaration classNode) {
    for (final annotation in classNode.metadata) {
      final name = annotation.name.toString();
      if (name == 'ExceptionUiConfig') {
        final args = annotation.arguments?.arguments ?? [];

        String? titleKey;
        String? descriptionKey;
        String? snackbarKey;

        for (final arg in args) {
          if (arg is NamedExpression) {
            final argName = arg.name.label.name;
            final value = arg.expression;

            switch (argName) {
              case 'titleKey':
                titleKey = _extractStringValue(value);
              case 'descriptionKey':
                descriptionKey = _extractStringValue(value);
              case 'snackbarKey':
                snackbarKey = _extractStringValue(value);
            }
          }
        }

        if (descriptionKey == null) {
          throw Exception(
            'ExceptionUiConfig must have descriptionKey for ${classNode.name.lexeme}',
          );
        }

        return ExceptionUiConfigData(
          titleKey: titleKey,
          descriptionKey: descriptionKey,
          snackbarKey: snackbarKey,
        );
      }
    }

    return null;
  }

  String? _extractStringValue(Expression expression) {
    if (expression is SimpleStringLiteral) {
      return expression.value;
    }
    return null;
  }
}

/// Generates ExceptionUiMapper boilerplate code
class ExceptionUiMapperGenerator {
  final List<ExceptionFactory> factories;

  ExceptionUiMapperGenerator(this.factories);

  String generateMapperMethods() {
    final buffer = StringBuffer();

    buffer.writeln('  /// Maps domain exception to UI model');
    buffer.writeln('  ExceptionUiModel map(AppException exception) {');
    buffer.writeln('    return switch (exception) {');

    for (final factory in factories) {
      if (factory.parameters.isEmpty) {
        buffer.writeln(
            '      ${factory.className}() => ${factory.mapperMethodName}(),');
      } else {
        final destructuredParams = factory.parameters
            .map((p) => '${p.name}: final ${p.name}')
            .join(', ');
        final paramNames = factory.parameters.map((p) => p.name).join(', ');
        buffer.writeln(
            '      ${factory.className}($destructuredParams) => ${factory.mapperMethodName}($paramNames),');
      }
    }

    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    for (final factory in factories) {
      buffer.write(_generateMapMethod(factory));
      buffer.writeln();
    }

    return buffer.toString();
  }

  String _generateMapMethod(ExceptionFactory factory) {
    final buffer = StringBuffer();

    buffer.writeln('  /// Maps ${factory.className}');
    buffer.writeln('  @protected');
    buffer.write('  ExceptionUiModel ${factory.mapperMethodName}(');

    final params =
        factory.parameters.map((p) => '${p.type} ${p.name}').join(', ');
    buffer.write(params);
    buffer.writeln(') {');

    final config = factory.config;

    buffer.writeln('    return ExceptionUiModel(');

    // Required parameters first
    final hasMessage = factory.parameters.any((p) => p.name == 'message');
    if (hasMessage) {
      buffer.writeln(
        '      description: message ?? _localizer.${config.descriptionKey},',
      );
    } else {
      buffer.writeln('      description: _localizer.${config.descriptionKey},');
    }

    final snackbarKey = config.snackbarKey ?? config.descriptionKey;
    if (hasMessage) {
      buffer.writeln(
        '      snackbarDescription: message ?? _localizer.$snackbarKey,',
      );
    } else {
      buffer.writeln('      snackbarDescription: _localizer.$snackbarKey,');
    }

    // Optional parameters after required
    if (config.titleKey != null) {
      buffer.writeln('      title: _localizer.${config.titleKey},');
    }

    buffer.writeln('      canRetry: ${factory.canRetry},');

    buffer.writeln('    );');
    buffer.writeln('  }');

    return buffer.toString();
  }

  String generateDecoratorDelegations() {
    final buffer = StringBuffer();

    for (final factory in factories) {
      buffer.writeln('  @override');
      buffer.write('  ExceptionUiModel ${factory.mapperMethodName}(');

      final params =
          factory.parameters.map((p) => '${p.type} ${p.name}').join(', ');
      buffer.write(params);

      buffer.write(') => wrapped.${factory.mapperMethodName}(');

      final paramNames = factory.parameters.map((p) => p.name).join(', ');
      buffer.write(paramNames);

      buffer.writeln(');');
      buffer.writeln();
    }

    return buffer.toString();
  }

  Future<void> writeToFiles({
    required String mapperFilePath,
    required String decoratorFilePath,
  }) async {
    final mapperFile = File(mapperFilePath);
    final decoratorFile = File(decoratorFilePath);

    await _updateFile(
      mapperFile,
      startMarker: '  // START GENERATED METHODS',
      endMarker: '  // END GENERATED METHODS',
      content: generateMapperMethods(),
    );

    await _updateFile(
      decoratorFile,
      startMarker: '  // START GENERATED DELEGATIONS',
      endMarker: '  // END GENERATED DELEGATIONS',
      content: generateDecoratorDelegations(),
    );
  }

  Future<void> _updateFile(
    File file, {
    required String startMarker,
    required String endMarker,
    required String content,
  }) async {
    final lines = await file.readAsLines();
    final buffer = StringBuffer();

    var inGeneratedSection = false;
    var foundSection = false;

    for (final line in lines) {
      if (line.contains(startMarker)) {
        inGeneratedSection = true;
        foundSection = true;
        buffer.writeln(line);
        buffer.write(content);
        continue;
      }

      if (line.contains(endMarker)) {
        inGeneratedSection = false;
        buffer.writeln(line);
        continue;
      }

      if (!inGeneratedSection) {
        buffer.writeln(line);
      }
    }

    if (!foundSection) {
      throw Exception('Could not find generation markers in ${file.path}');
    }

    await file.writeAsString(buffer.toString());
  }
}
