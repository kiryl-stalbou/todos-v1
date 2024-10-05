import 'dart:async' show StreamController, StreamSubscription;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'states/debug_error_screen.dart';
import 'states/release_error_screen.dart';

class UncaughtErrors extends StatefulWidget {
  const UncaughtErrors({required this.controller, required this.child, super.key});

  final StreamController<void> controller;
  final Widget child;

  @override
  State<UncaughtErrors> createState() => _UncaughtErrorsState();
}

class _UncaughtErrorsState extends State<UncaughtErrors> {
  late final StreamSubscription<void> _subscription;

  final _errors = <(Object, StackTrace)>[];

  @override
  void initState() {
    super.initState();

    _subscription = widget.controller.stream.listen(
      null,
      // ignore: avoid_types_on_closure_parameters
      onError: (Object error, StackTrace stackTrace) {
        setState(() => _errors.add((error, stackTrace)));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // ignore: discarded_futures
    _subscription.cancel();
    // ignore: discarded_futures
    widget.controller.close();
  }

  @override
  Widget build(BuildContext context) {
    if (_errors.isEmpty) return widget.child;

    if (kDebugMode) return DebugErrorScreen(_errors);

    return const ReleaseErrorScreen();
  }
}
