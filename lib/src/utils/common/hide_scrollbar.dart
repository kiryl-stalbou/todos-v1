import 'package:flutter/material.dart';

class HideScrollbarBehavior extends MaterialScrollBehavior {
  const HideScrollbarBehavior();
  
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
