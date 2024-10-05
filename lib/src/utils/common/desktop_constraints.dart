import 'package:flutter/material.dart';

class DesktopConstraints extends StatelessWidget {
  const DesktopConstraints({
    required this.child,
    this.maxWidth = 500,
    super.key,
  });

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      );
}
