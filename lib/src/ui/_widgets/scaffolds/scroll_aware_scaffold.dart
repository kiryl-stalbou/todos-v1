import 'package:flutter/material.dart';

import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import 'app_scaffold.dart';

class ScrollAwareScaffold extends StatelessWidget {
  const ScrollAwareScaffold({
    required this.body,
    this.resizeToAvoidBottomInset = false,
    this.extendBodyBehindTop = false,
    this.extendBodyBehindBottom = false,
    this.color,
    this.top,
    this.bottom,
    super.key,
  });

  final Widget body;
  final bool extendBodyBehindTop;
  final bool extendBodyBehindBottom;
  final bool resizeToAvoidBottomInset;
  final Color? color;
  final Widget? top;
  final Widget? bottom;

  Future<void> _scrollToTop(BuildContext context) => PrimaryScrollController.of(context).animateTo(
        0,
        curve: AppCurves.autoScroll,
        duration: AppDurations.autoScroll,
      );

  @override
  Widget build(BuildContext context) => ScrollNotificationObserver(
        child: AppScaffold(
          body: body,
          top: top,
          bottom: bottom,
          color: color,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindTop: extendBodyBehindTop,
          extendBodyBehindBottom: extendBodyBehindBottom,
          statusBar: GestureDetector(
            excludeFromSemantics: true,
            behavior: HitTestBehavior.opaque,
            onTap: () async => _scrollToTop(context),
          ),
        ),
      );
}
