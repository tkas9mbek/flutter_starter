library starter_lints;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:starter_lints/src/lints/always_spread_in_collections.dart';
import 'package:starter_lints/src/lints/avoid_widget_functions.dart';
import 'package:starter_lints/src/lints/blank_line_before_return.dart';
import 'package:starter_lints/src/lints/bloc_no_bloc_dependency.dart';
import 'package:starter_lints/src/lints/prefer_arrow_except_build_and_nested.dart';
import 'package:starter_lints/src/lints/prefer_named_parameters.dart';
import 'package:starter_lints/src/lints/sort_constructor_params.dart';

PluginBase createPlugin() => _StarterLints();

class _StarterLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const AvoidWidgetFunctions(),
    const PreferArrowExceptBuild(),
    const AlwaysSpreadInCollections(),
    const BlocNoBlocDependency(),
    const BlankLineBeforeReturn(),
    const PreferNamedParameters(),
    const SortConstructorParams(),
  ];
}
