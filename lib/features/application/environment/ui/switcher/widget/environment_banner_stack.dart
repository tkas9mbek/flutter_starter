import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_logger/widget/request_logger_button.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter_uikit/theme/app_colors.dart';

class EnvironmentBannerStack extends StatelessWidget {
  const EnvironmentBannerStack({
    required this.child,
    required this.navigatorKey,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topRight,
          child: Material(
            color: AppColors.transparent,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.sizeOf(context).width * 0.25,
                ),
                child: BlocBuilder<EnvironmentCubit, AppEnvironment>(
                  builder: (context, env) => env.showBanner
                      ? RequestLoggerButton(
                          label: env.name,
                          navigatorKey: navigatorKey,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
