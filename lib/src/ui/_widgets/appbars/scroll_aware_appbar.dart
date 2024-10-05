import 'package:flutter/material.dart';

import '../animated/scroll_aware_default_text_style.dart';
import '../animated/scroll_aware_elevation.dart';
import 'static_appbar.dart';

class ScrollAwareAppBar extends StatelessWidget {
  const ScrollAwareAppBar({
    this.title,
    this.actions,
    this.titleSpacing,
    this.showTitleScrollExtent,
    super.key,
  });

  final Widget? title;
  final double? titleSpacing;
  final List<Widget>? actions;
  final double? showTitleScrollExtent;

  @override
  Widget build(BuildContext context) {
    Widget? title = this.title;

    final showTitleScrollExtent = this.showTitleScrollExtent;
    if (title != null && showTitleScrollExtent != null) {
      title = ScrollAwareDefaultTextStyle(showTextScrollExtent: showTitleScrollExtent, child: title);
    }

    return ScrollAwareElevation(
      child: StaticAppBar(
        title: title,
        actions: actions,
        titleSpacing: titleSpacing,
      ),
    );
  }
}
