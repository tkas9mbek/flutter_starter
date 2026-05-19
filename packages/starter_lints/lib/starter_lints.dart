library starter_lints;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:starter_lints/src/lints/always_spread_in_collections.dart';
import 'package:starter_lints/src/lints/avoid_build_context_field.dart';
import 'package:starter_lints/src/lints/avoid_mutable_bloc_fields.dart';
import 'package:starter_lints/src/lints/avoid_naming_antipatterns.dart';
import 'package:starter_lints/src/lints/avoid_widget_functions.dart';
import 'package:starter_lints/src/lints/blank_line_before_return.dart';
import 'package:starter_lints/src/lints/bloc_listener_builder_usage.dart';
import 'package:starter_lints/src/lints/bloc_no_bloc_dependency.dart';
import 'package:starter_lints/src/lints/braces_in_flow_control.dart';
import 'package:starter_lints/src/lints/class_size_warning.dart';
import 'package:starter_lints/src/lints/max_widget_nesting.dart';
import 'package:starter_lints/src/lints/multi_line_ternary.dart';
import 'package:starter_lints/src/lints/no_flutter_in_data_domain.dart';
import 'package:starter_lints/src/lints/no_hardcoded_colors.dart';
import 'package:starter_lints/src/lints/prefer_arrow_except_build_and_nested.dart';
import 'package:starter_lints/src/lints/prefer_bool_default.dart';
import 'package:starter_lints/src/lints/prefer_map_or_null.dart';
import 'package:starter_lints/src/lints/sort_constructor_params.dart';
import 'package:starter_lints/src/lints/theme_in_build_only.dart';

PluginBase createPlugin() => _StarterLints();

class _StarterLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const AvoidWidgetFunctions(),
    const PreferArrowExceptBuild(),
    const AlwaysSpreadInCollections(),
    const BlocNoBlocDependency(),
    const BlankLineBeforeReturn(),
    const SortConstructorParams(),
    const NoFlutterInDataDomain(),
    const BracesInFlowControl(),
    const NoHardcodedColors(),
    const AvoidBuildContextField(),
    const AvoidMutableBlocFields(),
    const PreferMapOrNull(),
    const PreferBoolDefault(),
    const AvoidNamingAntipatterns(),
    const BlocListenerBuilderUsage(),
    const ClassSizeWarning(),
    const MaxWidgetNesting(),
    const MultiLineTernary(),
    const ThemeInBuildOnly(),
  ];
}
