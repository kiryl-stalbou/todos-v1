import 'package:flutter/material.dart';

import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../constants/sizes.dart';
import '../../../l10n/s.dart';
import '../../_widgets/animated/_animated_state.dart';
import '../../_widgets/common/spacers.dart';
import '../../_widgets/indicators/circular_loading_indicator.dart';
import 'global_loading_status.dart';

class GlobalLoadingScreen extends StatelessWidget {
  const GlobalLoadingScreen(this.status, {super.key});

  final GlobalLoadingStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return ColoredBox(
      color: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _LoadingIcon(status),

          const VSpacer(Insets.xl),

          Text(
            s.key(status.localizationKey),
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon(this.status);

  final GlobalLoadingStatus status;

  static const double _size = 70;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: _size,
        child: Center(
          child: switch (status) {
            GlobalLoadingActive() => const CircularLoadingIndicator(dimension: _size * 0.9),
            GlobalLoadingSuccess() => const _AnimatedScaledIcon(true),
            GlobalLoadingFailed() => const _AnimatedScaledIcon(false),
          },
        ),
      );
}

class _AnimatedScaledIcon extends StatefulWidget {
  const _AnimatedScaledIcon(this.isSuccessful);

  final bool isSuccessful;

  @override
  State<_AnimatedScaledIcon> createState() => _AnimatedScaledIconState();
}

class _AnimatedScaledIconState extends AnimatedBuilderState1<_AnimatedScaledIcon> {
  late final Animatable<double> _scaleTween;

  @override
  Duration get forwardDuration => AppDurations.globalLoadingScreenAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: AppCurves.scale));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final icon = widget.isSuccessful ? Icons.check_rounded : Icons.close_rounded;
    final fillColor = widget.isSuccessful ? colorScheme.primary : colorScheme.error;
    final iconColor = widget.isSuccessful ? colorScheme.onPrimary : colorScheme.onError;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, child) => Transform.scale(scale: _scaleTween.evaluate(animationController), child: child),
        child: DecoratedBox(
          decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: _LoadingIcon._size * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
