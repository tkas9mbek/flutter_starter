import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
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

/// Parsed exception factory information
class ExceptionFactory {
  final String name;
  final String className;
  final List<FactoryParameter> parameters;
  final ExceptionUiConfigData config;

  ExceptionFactory({
    required this.name,
    required this.className,
    required this.parameters,
    required this.config,
  });

  String get mapperMethodName => 'map${_capitalize(name)}';

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
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
  final bool canRetry;
  final bool canRefresh;

  ExceptionUiConfigData({
    this.titleKey,
    required this.descriptionKey,
    this.snackbarKey,
    this.canRetry = true,
    this.canRefresh = true,
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
    if (node.name.lexeme != 'AppException') return;

    for (final member in node.members) {
      if (member is ConstructorDeclaration && member.factoryKeyword != null) {
        _parseFactory(member);
      }
    }
  }

  void _parseFactory(ConstructorDeclaration constructor) {
    final factoryName = constructor.name?.lexeme;
    if (factoryName == null || factoryName == '_') return;

    final config = _parseAnnotation(constructor);
    if (config == null) return;

    final parameters = <FactoryParameter>[];
    final params = constructor.parameters.parameters;
    for (final param in params) {
      if (param is SimpleFormalParameter) {
        parameters.add(FactoryParameter(
          name: param.name!.lexeme,
          type: param.type?.toString() ?? 'dynamic',
          isRequired: param.isRequired,
        ));
      } else if (param is DefaultFormalParameter) {
        final normalParam = param.parameter;
        if (normalParam is SimpleFormalParameter) {
          parameters.add(FactoryParameter(
            name: normalParam.name!.lexeme,
            type: normalParam.type?.toString() ?? 'dynamic',
            isRequired: param.isRequired,
          ));
        }
      }
    }

    final redirect = constructor.redirectedConstructor?.toString() ?? '';
    final className = redirect.replaceAll('= ', '').trim();

    factories.add(ExceptionFactory(
      name: factoryName,
      className: className,
      parameters: parameters,
      config: config,
    ));
  }

  ExceptionUiConfigData? _parseAnnotation(ConstructorDeclaration constructor) {
    for (final annotation in constructor.metadata) {
      final name = annotation.name.toString();
      if (name == 'ExceptionUiConfig') {
        final args = annotation.arguments?.arguments ?? [];

        String? titleKey;
        String? descriptionKey;
        String? snackbarKey;
        var canRetry = true;
        var canRefresh = true;

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
              case 'canRetry':
                canRetry = _extractBoolValue(value);
              case 'canRefresh':
                canRefresh = _extractBoolValue(value);
            }
          }
        }

        if (descriptionKey == null) {
          throw Exception(
            'ExceptionUiConfig must have descriptionKey for ${constructor.name}',
          );
        }

        return ExceptionUiConfigData(
          titleKey: titleKey,
          descriptionKey: descriptionKey,
          snackbarKey: snackbarKey,
          canRetry: canRetry,
          canRefresh: canRefresh,
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

  bool _extractBoolValue(Expression expression) {
    if (expression is BooleanLiteral) {
      return expression.value;
    }
    return true;
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
    buffer.writeln('    return exception.when(');

    for (final factory in factories) {
      buffer.writeln('      ${factory.name}: ${factory.mapperMethodName},');
    }

    buffer.writeln('    );');
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

    if (config.titleKey != null) {
      buffer.writeln('      title: _toolkitLocalizer.${config.titleKey},');
    }

    final hasMessage = factory.parameters.any((p) => p.name == 'message');
    if (hasMessage) {
      buffer.writeln(
        '      description: message ?? _toolkitLocalizer.${config.descriptionKey},',
      );
    } else {
      buffer.writeln(
          '      description: _toolkitLocalizer.${config.descriptionKey},');
    }

    final snackbarKey = config.snackbarKey ?? config.descriptionKey;
    if (hasMessage) {
      buffer.writeln(
        '      snackbarDescription: message ?? _toolkitLocalizer.$snackbarKey,',
      );
    } else {
      buffer.writeln(
          '      snackbarDescription: _toolkitLocalizer.$snackbarKey,');
    }

    buffer.writeln('      canRefresh: ${config.canRefresh},');
    buffer.writeln('      canRetry: ${config.canRetry},');

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
