import 'package:flutter/material.dart';
import 'package:starter/features/application/environment/ui/widget/environment_banner_stack.dart';
import 'package:starter_uikit/widgets/misc/input_accessory_view_wrapper.dart';

class ApplicationWrapper extends StatelessWidget {
  const ApplicationWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

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
        child: InputAccessoryViewWrapper(
          child: child,
        ),
      ),
    );
  }
}
