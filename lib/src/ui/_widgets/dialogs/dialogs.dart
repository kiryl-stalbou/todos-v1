import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/colors.dart';
import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../l10n/lk.dart';
import 'impl/action_dialog.dart';
import 'impl/confirm_dialog.dart';
import 'impl/exception_dialog.dart';

abstract final class Dialogs {
  static Future<void> showException(
    BuildContext context, {
    required String subtitleLk,
    String titleLk = Lk.errorUnexpectedTitle,
  }) =>
      _showAnimatedDialog<void>(
        context,
        settings: const RouteSettings(name: 'ErrorDialog'),
        body: ExceptionDialog(titleLk: titleLk, subtitleLk: subtitleLk),
      );

  static Future<bool> showConfirm(
    BuildContext context, {
    required String titleLk,
    required String subtitleLk,
    required String confirmLk,
  }) async =>
      await _showAnimatedDialog<bool>(
        context,
        settings: const RouteSettings(name: 'ConfirmDialog'),
        body: ConfirmDialog(titleLk: titleLk, subtitleLk: subtitleLk, confirmLk: confirmLk),
      ) ??
      false;

  static Future<bool> showActions(
    BuildContext context, {
    required String titleLk,
    required String subtitleLk,
    required List<Widget> actions,
  }) async =>
      await _showAnimatedDialog<bool>(
        context,
        settings: const RouteSettings(name: 'ActionDialog'),
        body: ActionDialog(titleLk: titleLk, subtitleLk: subtitleLk, actions: actions),
      ) ??
      false;
}

Future<T?> _showAnimatedDialog<T>(
  BuildContext context, {
  required Widget body,
  required RouteSettings settings,
}) =>
    showGeneralDialog<T>(
      transitionDuration: AppDurations.dialog,
      barrierColor: AppColors.barrierColor,
      barrierLabel: 'Dissmisable dialog',
      barrierDismissible: true,
      routeSettings: settings,
      useRootNavigator: false,
      context: context,
      pageBuilder: (_, __, ___) => body,
      transitionBuilder: (_, animation, __, child) {
        final animation1 = CurvedAnimation(parent: animation, curve: AppCurves.fade);
        final animation2 = CurvedAnimation(parent: animation, curve: AppCurves.rotate);

        return FadeTransition(
          opacity: animation1,
          child: ScaleTransition(
            scale: animation1,
            child: Transform.rotate(
              angle: (-pi / 10) + (pi * animation2.value / 10),
              child: child,
            ),
          ),
        );
      },
    );
