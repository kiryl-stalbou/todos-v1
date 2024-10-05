import 'package:flutter/material.dart';

import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../utils/mixins/scroll_observer_state_mixin.dart';

class ScrollAwareDefaultTextStyle extends StatefulWidget {
  const ScrollAwareDefaultTextStyle({
    required this.showTextScrollExtent,
    required this.child,
    super.key,
  }) : assert(showTextScrollExtent > 0);

  final Widget child;
  final double showTextScrollExtent;

  @override
  State<ScrollAwareDefaultTextStyle> createState() => _ScrollAwareDefaultTextStyleState();
}

class _ScrollAwareDefaultTextStyleState extends State<ScrollAwareDefaultTextStyle> with ScrollObserverStateMixin {
  bool _showText = false;

  @override
  void onScrollNotification(ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification || notification.depth != 0) return;

    final oldShowText = _showText;

    _showText = notification.metrics.extentBefore >= widget.showTextScrollExtent;

    if (oldShowText != _showText) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final parent = DefaultTextStyle.of(context);

    return RepaintBoundary(
      child: AnimatedDefaultTextStyle(
        duration: AppDurations.fade,
        curve: AppCurves.fade,
        style: parent.style.copyWith(
          color: parent.style.color?.withOpacity(_showText ? 1 : 0),
        ),
        softWrap: parent.softWrap,
        maxLines: parent.maxLines,
        overflow: parent.overflow,
        textAlign: parent.textAlign,
        textWidthBasis: parent.textWidthBasis,
        textHeightBehavior: parent.textHeightBehavior,
        child: widget.child,
      ),
    );
  }
}
