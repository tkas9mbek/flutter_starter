import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({
    required this.switchSize,
    required this.switchPadding,
    required this.width,
    this.value = false,
    this.onChanged,
    this.color,
    super.key,
  });

  const AppSwitch.small({
    this.value = false,
    this.onChanged,
    this.color,
    super.key,
  })  : switchSize = 21,
        switchPadding = const EdgeInsets.all(1.5),
        width = 39;

  const AppSwitch.big({
    this.value = false,
    this.onChanged,
    this.color,
    super.key,
  })  : switchSize = 27,
        switchPadding = const EdgeInsets.all(2),
        width = 51;

  final Color? color;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double width;
  final double switchSize;
  final EdgeInsets switchPadding;

  @override
  _AppSwitchState createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late bool value = widget.value;

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    if (value != widget.value) {
      setState(() => value = widget.value);
    }

    super.didUpdateWidget(oldWidget);
  }

  void onTap() {
    setState(() => value = !value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final color = widget.color ?? theme.primary;
    final height = widget.switchSize + widget.switchPadding.vertical;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widget.width,
        height: height,
        padding: widget.switchPadding,
        decoration: BoxDecoration(
          color: value ? color : theme.border,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value
                  ? widget.width -
                      widget.switchSize -
                      widget.switchPadding.horizontal
                  : 0,
              child: SizedBox(
                width: widget.switchSize,
                height: widget.switchSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.background,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
