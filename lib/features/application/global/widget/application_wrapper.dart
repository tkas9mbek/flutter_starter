import 'package:flutter/material.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/environment_banner_stack.dart';
import 'package:starter_uikit/widgets/misc/input_accessory_view_wrapper.dart';

class ApplicationWrapper extends StatelessWidget {
  const ApplicationWrapper({
    required this.child,
    required this.navigatorKey,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: EnvironmentBannerStack(
        navigatorKey: navigatorKey,
        child: InputAccessoryViewWrapper(child: child),
      ),
    );
  }
}
