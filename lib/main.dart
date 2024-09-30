import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> configureApplication() async {
  await configureDependencies();

  final modules = [

  ];

  for (final module in modules) {
    await module.registerDependencies();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureApplication();

  runApp(const Application());
}
