import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/environment_banner_stack.dart';
import 'package:starter_uikit/widgets/misc/input_accessory_view_wrapper.dart';

/// Unfocuses on outside taps and hosts the environment banner and the iOS
/// input accessory. Placed in a `Nested` list, which supplies the child.
class ApplicationWrapper extends SingleChildStatelessWidget {
  const ApplicationWrapper({
    required this.navigatorKey,
    super.key,
    super.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: EnvironmentBannerStack(
        navigatorKey: navigatorKey,
        child: InputAccessoryViewWrapper(child: child!),
      ),
    );
  }
}
