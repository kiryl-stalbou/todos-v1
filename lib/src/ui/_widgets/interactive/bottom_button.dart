import 'package:flutter/material.dart';

import '../common/paddings.dart';
import 'app_button.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.onTap,
    required this.child,
    this.fadeBackground = false,
    this.listenLocalLoading = false,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool fadeBackground;
  final bool listenLocalLoading;

  @override
  Widget build(BuildContext context) {
    Widget child = AppSafePadding(
      child: AppButton(
        onTap: onTap,
        listenLocalLoading: listenLocalLoading,
        child: this.child,
      ),
    );

    if (fadeBackground) {
      final fadeColor = Theme.of(context).colorScheme.surface;

      child = DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              fadeColor.withOpacity(1),
              fadeColor.withOpacity(0.84),
              fadeColor.withOpacity(0),
            ],
          ),
        ),
        child: child,
      );
    }

    return child;
  }
}
