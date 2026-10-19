import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/di/app_configurator.dart';
import 'package:starter/core/global/firebase_config.dart';
import 'package:starter/features/application/application.dart';
import 'package:starter_toolkit/utils/crash/crash_reporter.dart' as crash;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (FirebaseConfig.enabled) {
    await _configureFirebaseCrashReporting();
  }

  await AppConfigurator.configure();

  runApp(const Application());
}

Future<void> _configureFirebaseCrashReporting() async {
  try {
    await Firebase.initializeApp();

    // Debug builds report to the console instead, so local crashes don't
    // pollute the dashboard.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      !kDebugMode,
    );

    crash.crashReporter = const crash.FirebaseCrashReporter();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          fatal: true,
        ),
      );

      return true;
    };
  } on Object catch (error, stackTrace) {
    log(
      'Firebase crash reporting setup failed',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
