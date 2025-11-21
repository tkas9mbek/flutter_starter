import 'package:flutter/material.dart';
import 'package:starter/core/di/app_configurator.dart';
import 'package:starter/features/application/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfigurator.configure();

  runApp(const Application());
}
