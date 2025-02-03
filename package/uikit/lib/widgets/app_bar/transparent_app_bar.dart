import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/app_bar/app_bar_content.dart';
import 'package:uikit/widgets/app_bar/title_app_bar.dart';

class TransparentAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// App bar that becomes transparent when the user scrolls down.
  /// The app bar will be visible when the user scrolls up.
  /// * [transparentHeight] is the height at which the app bar becomes transparent.
  /// * [scrollController] is the controller that will be used to determine the scroll position.
  const TransparentAppBar({
    required this.title,
    required this.scrollController,
    this.transparentHeight = 0,
    this.automaticallyImplyLeading = true,
    this.height = 52,
    this.actions,
    this.bottom,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double height;
  final double transparentHeight;
  final ScrollController scrollController;
  final PreferredSizeWidget? bottom;

  @override
  State<TransparentAppBar> createState() => _TransparentAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

class _TransparentAppBarState extends State<TransparentAppBar> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController.offset > widget.transparentHeight) {
      if (!visible) {
        setState(() => visible = true);
      }
    } else {
      if (visible) {
        setState(() => visible = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: visible
          ? TitleAppBar(
              key: const ValueKey('visible'),
              title: widget.title,
              actions: widget.actions,
              automaticallyImplyLeading: widget.automaticallyImplyLeading,
              height: widget.height,
              bottom: widget.bottom,
            )
          : AppBar(
              key: const ValueKey('transparent'),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              elevation: 0,
              centerTitle: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.background,
                      theme.background.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: widget.bottom?.preferredSize ?? Size.zero,
                child: Opacity(
                  opacity: 0,
                  child: widget.bottom,
                ),
              ),
              title: SizedBox(
                height: widget.height,
                child: AppBarContent(
                  title: widget.title,
                  automaticallyImplyLeading: widget.automaticallyImplyLeading,
                  actions: widget.actions,
                ),
              ),
            ),
    );
  }
}
