import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../constants/sizes.dart';

class AppPadding extends StatelessWidget {
  const AppPadding({
    required this.child,
    this.top = 0,
    this.bottom = 0,
    super.key,
  });

  final double top;
  final double bottom;
  final Widget child;

  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: Insets.l);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: top,
          bottom: bottom,
          left: horizontal.left,
          right: horizontal.right,
        ),
        child: child,
      );
}

class AppSafePadding extends StatelessWidget {
  const AppSafePadding({
    required this.child,
    this.extraTop = 0,
    this.extraBottom = 0,
    super.key,
  });

  final double extraTop;
  final double extraBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return AppPadding(
      top: padding.top + extraTop,
      bottom: math.max(Insets.m, padding.bottom) + extraBottom,
      child: child,
    );
  }
}
