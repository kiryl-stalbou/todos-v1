import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/durations.dart';
import '../../../exceptions/try_catch.dart';

import '../../../l10n/lk.dart';
import '../../../utils/common/hide_keyboard.dart';
import '../../_widgets/animated/animated_translation.dart';
import '../../_widgets/dialogs/dialogs.dart';
import 'global_loading_screen.dart';
import 'global_loading_status.dart';

class GlobalLoading extends StatefulWidget {
  const GlobalLoading({required this.child, super.key});

  final Widget child;

  static Future<(bool, R?)> run<R>(
    BuildContext context,
    EitherFuture<R> Function() fn, {
    required String activeLk,
    required String successLk,
    required String failedLk,
  }) =>
      of(context).run(
        context,
        fn,
        activeLk: activeLk,
        successLk: successLk,
        failedLk: failedLk,
      );

  static GlobalLoadingState of(BuildContext context) {
    final state = context.getInheritedWidgetOfExactType<_GlobalLoadingInheritedWidget>()?.state;

    if (state == null) throw Exception('Invalid context: missing _GlobalLoadingInheritedWidget');

    return state;
  }

  @override
  State<GlobalLoading> createState() => GlobalLoadingState();
}

class GlobalLoadingState extends State<GlobalLoading> {
  bool _showLoadingScreen = false;

  void _setStatus(GlobalLoadingStatus? status) => setState(() => _status = status);
  GlobalLoadingStatus? get status => _status;
  GlobalLoadingStatus? _status;

  /// Calls function asynchronously changing
  /// [status] value depends on loading state.
  ///
  /// If successful returns `(true ,R?)`, otherwise returns `(false, null)`
  /// and shows exception dialog
  Future<(bool, R?)> run<R>(
    BuildContext context,
    EitherFuture<R?> Function() fn, {
    required String activeLk,
    required String successLk,
    required String failedLk,
  }) async {
    if (_status != null) return (false, null);

    hideKeyBoard();

    setState(() => _showLoadingScreen = true);
    _setStatus(GlobalLoadingActive(activeLk));
    await Future<void>.delayed(AppDurations.slide);

    final (exception, data) = await fn();
    await Future<void>.delayed(AppDurations.aestheticDelay);
    _setStatus(exception == null ? GlobalLoadingSuccess(successLk) : GlobalLoadingFailed(failedLk));
    await Future<void>.delayed(AppDurations.globalLoadingScreenAnimationDelay);
    setState(() => _showLoadingScreen = false);

    await Future<void>.delayed(AppDurations.slide);
    _setStatus(null);

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
  Widget build(BuildContext context) {
    final status = _status;

    return _GlobalLoadingInheritedWidget(
      state: this,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          //
          widget.child,

          if (status != null)
            AnimatedTranslation.fractional(
              animateOnMount: true,
              duration: AppDurations.slide,
              from: _showLoadingScreen ? const Offset(0, 1) : Offset.zero,
              to: _showLoadingScreen ? Offset.zero : const Offset(0, 1),
              child: GlobalLoadingScreen(status),
            ),
        ],
      ),
    );
  }
}

class _GlobalLoadingInheritedWidget extends InheritedWidget {
  const _GlobalLoadingInheritedWidget({required this.state, required super.child});

  final GlobalLoadingState state;

  @override
  bool updateShouldNotify(_GlobalLoadingInheritedWidget oldWidget) => false;
}
