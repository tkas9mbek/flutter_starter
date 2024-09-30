import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class AppCupertinoPicker<T> extends StatefulWidget {
  /// A picker that allows the user to select a value from a list.
  /// The user can scroll through the list to select a value.
  /// * [values] is a list of values to choose from.
  /// * [valueToString] is a function that converts a value to a string.
  const AppCupertinoPicker({
    required this.values,
    required this.onValueChanged,
    required this.valueToString,
    this.selectedValue,
    super.key,
  });

  final List<T> values;
  final void Function(T value) onValueChanged;
  final String Function(T value) valueToString;
  final T? selectedValue;

  @override
  State<AppCupertinoPicker<T>> createState() => _AppCupertinoPickerState<T>();
}

class _AppCupertinoPickerState<T> extends State<AppCupertinoPicker<T>> {
  late int selectedValueIndex = widget.selectedValue == null
      ? 0
      : widget.values.indexOf(widget.selectedValue as T);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return CupertinoPicker(
      useMagnifier: true,
      looping: true,
      itemExtent: 35,
      onSelectedItemChanged: (int index) {
        widget.onValueChanged(widget.values[index]);
        setState(() => selectedValueIndex = index);
      },
      selectionOverlay: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: theme.border,
              width: 1,
            ),
          ),
        ),
      ),
      children: widget.values.map((value) {
        final index = widget.values.indexOf(value);
        late final TextStyle textStyle;

        if (index == selectedValueIndex) {
          textStyle = textStyles.labelLarge;
        } else {
          textStyle = textStyles.bodyLarge.copyWith(
            color: theme.onBackground.withOpacity(0.75),
          );
        }

        return Center(
          child: Text(
            widget.valueToString(value),
            style: textStyle,
          ),
        );
      }).toList(),
    );
  }
}
