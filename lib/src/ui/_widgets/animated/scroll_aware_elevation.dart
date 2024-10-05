import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../utils/mixins/scroll_observer_state_mixin.dart';

class ScrollAwareElevation extends StatefulWidget {
  const ScrollAwareElevation({required this.child, super.key});

  final Widget child;

  @override
  State<ScrollAwareElevation> createState() => _ScrollAwareElevationState();
}

class _ScrollAwareElevationState extends State<ScrollAwareElevation> with ScrollObserverStateMixin {
  bool _scrolledUnder = false;

  @override
  void onScrollNotification(ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification || notification.depth != 0) return;

    final oldScrolledUnder = _scrolledUnder;
    final m = notification.metrics;

    if (m.axisDirection == AxisDirection.up) _scrolledUnder = m.extentAfter > 0;
    if (m.axisDirection == AxisDirection.down) _scrolledUnder = m.extentBefore > 0;

    if (oldScrolledUnder != _scrolledUnder) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return RepaintBoundary(
      child: AnimatedPhysicalModel(
        elevation: _scrolledUnder ? appBarTheme.scrolledUnderElevation ?? 0 : 0,
        shadowColor: appBarTheme.shadowColor ?? AppColors.red,
        color: appBarTheme.backgroundColor ?? AppColors.red,
        duration: AppDurations.fade,
        shape: BoxShape.rectangle,
        curve: AppCurves.fade,
        child: widget.child,
      ),
    );
  }
}
