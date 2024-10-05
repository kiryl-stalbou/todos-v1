import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/durations.dart';
import '../../../exceptions/try_catch.dart';
import '../../../l10n/lk.dart';
import '../../_widgets/dialogs/dialogs.dart';

class LocalLoading extends StatefulWidget {
  const LocalLoading({required this.child, super.key});

  final Widget child;

  static bool isLoadingOf(BuildContext context) => of(context, listen: true).isLoading;

  static Future<R> wait<R>(BuildContext context, Future<R> future) => of(context).wait<R>(future);

  static Future<(bool, R?)> run<R>(BuildContext context, EitherFuture<R> Function() fn) => of(context).run<R>(context, fn);

  static LocalLoadingState of(BuildContext context, {bool listen = false}) {
    LocalLoadingState? state;

    if (listen) {
      state = context.dependOnInheritedWidgetOfExactType<_LocalLoadingInheritedWidget>()?.state;
    } else {
      state = context.getInheritedWidgetOfExactType<_LocalLoadingInheritedWidget>()?.state;
    }

    if (state == null) throw Exception('Invalid context: missing _LocalLoadingInheritedWidget');

    return state;
  }

  @override
  State<LocalLoading> createState() => LocalLoadingState();
}

class LocalLoadingState extends State<LocalLoading> {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setLoading(bool isLoading) {
    if (mounted) setState(() => _isLoading = isLoading);
  }

  /// Waits for provided [future] changing [isLoading] value
  /// depends on future status.
  Future<R> wait<R>(Future<R> future) async {
    assert(!isLoading, 'Cant load simultaneously, consider user isLoading value to block function invocation');
    _setLoading(true);
    final data = await future;
    await Future<void>.delayed(AppDurations.aestheticDelay);
    _setLoading(false);
    return data;
  }

  /// Calls function asynchronously changing [isLoading] value
  /// depends on loading state
  ///
  /// If successful returns `(true ,R?)`, otherwise returns `(false, null)`
  /// and shows error dialog
  Future<(bool, R?)> run<R>(BuildContext context, EitherFuture<R?> Function() fn) async {
    assert(!isLoading, 'Cant load simultaneously, consider user isLoading value to block function invocation');
    _setLoading(true);
    final (exception, data) = await fn();
    await Future<void>.delayed(AppDurations.aestheticDelay);
    _setLoading(false);
    if (exception == null) return (true, data);
    // ignore: use_build_context_synchronously
    return _showExceptionDialog(context, exception.code);
  }

  // ignore: prefer_void_to_null
  Future<(bool, Null)> _showExceptionDialog(BuildContext context, String exceptionCode) async {
    await Future<void>.delayed(AppDurations.aestheticDelay);
    if (context.mounted) await Dialogs.showException(context, subtitleLk: Lk.forCode(exceptionCode));
    return (false, null);
  }

  @override
  Widget build(BuildContext context) => _LocalLoadingInheritedWidget(
        state: this,
        isLoading: isLoading,
        child: widget.child,
      );
}

class _LocalLoadingInheritedWidget extends InheritedWidget {
  const _LocalLoadingInheritedWidget({
    required this.state,
    required this.isLoading,
    required super.child,
  });

  final bool isLoading;
  final LocalLoadingState state;

  @override
  bool updateShouldNotify(_LocalLoadingInheritedWidget oldWidget) => oldWidget.isLoading != isLoading;
}
