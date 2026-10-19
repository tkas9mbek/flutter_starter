import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/app_bar_content.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

/// App bar that stays transparent over a background gradient until the
/// [scrollController] offset passes [transparentHeight], then switches to a
/// solid [TitleAppBar] with an animated cross-fade.
class TransparentAppBar extends StatefulWidget implements PreferredSizeWidget {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.scrollController.hasClients) {
        _onScroll();
      }
    });
  }

  @override
  void didUpdateWidget(TransparentAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController.removeListener(_onScroll);
      widget.scrollController.addListener(_onScroll);
    }
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
          : _FadingAppBar(key: const ValueKey('transparent'), bar: widget),
    );
  }
}

class _FadingAppBar extends StatelessWidget {
  const _FadingAppBar({required this.bar, super.key});

  final TransparentAppBar bar;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      systemOverlayStyle: theme.themeMode == ThemeMode.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      // Fades from the page background so content scrolling under the bar
      // dissolves into the same plane instead of hitting a hard edge.
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.background, theme.background.withValues(alpha: 0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: bar.bottom?.preferredSize ?? Size.zero,
        child: IgnorePointer(child: Opacity(opacity: 0, child: bar.bottom)),
      ),
      title: SizedBox(
        height: bar.height,
        child: AppBarContent(
          title: bar.title,
          automaticallyImplyLeading: bar.automaticallyImplyLeading,
          actions: bar.actions,
        ),
      ),
    );
  }
}
