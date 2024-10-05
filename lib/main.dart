import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

import 'firebase_options.dart';
import 'src/logs/logger.dart';
import 'src/logs/widgets_binding_logger.dart';
import 'src/utils/common/path_url_strategy.dart';

// dart run build_runner build --delete-conflicting-outputs
// flutter build web --web-renderer canvaskit --release
// firebase deploy --only hosting

void main() async {
  await _initFlutter();

  await _initFirebase();

  runApp(TodoApp(uncaughtErrorsController: _initUncaughtErrorsController()));
}

Future<void> _initFlutter() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.addObserver(const WidgetsBindingLogger());

  // Tree shaking will delete this for non-web compilation
  if (kIsWeb) usePathUrlStrategy();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

StreamController<void> _initUncaughtErrorsController() {
  const l = Logger(library: 'lib/main.dart', method: '_initUncaughtErrorsController', params: '');

  final controller = StreamController<void>.broadcast();

  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    l.error(error, stack, reason: 'Uncaught Error!!!', fatal: true);

    controller.addError(error, stack);

    return true;
  };

  FlutterError.onError = (details) {
    if (!details.silent) {
      l.flutterError(details, fatal: true);

      controller.addError(details.exception, details.stack);
    }
  };

  return controller;
}
