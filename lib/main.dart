import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/app_configurator.dart';
import 'package:starter/features/application/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppConfigurator.configure();

  Bloc.transformer = sequential();

  runApp(const Application());
}
