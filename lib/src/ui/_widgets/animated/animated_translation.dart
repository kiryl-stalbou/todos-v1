import 'package:flutter/material.dart';

import '../../../constants/curves.dart';
import '_animated_state.dart';

class AnimatedTranslation extends StatefulWidget {
  const AnimatedTranslation({
    required this.from,
    required this.to,
    required this.child,
    required this.duration,
    this.animateOnMount = false,
    super.key,
  }) : fractional = false;

  const AnimatedTranslation.fractional({
    required this.from,
    required this.to,
    required this.child,
    required this.duration,
    this.animateOnMount = false,
    super.key,
  }) : fractional = true;

  final Widget child;
  final Offset from;
  final Offset to;
  final Duration duration;
  final bool animateOnMount;
  final bool fractional;

  @override
  State<AnimatedTranslation> createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState extends AnimatedState<AnimatedTranslation> {
  late final CurveTween _offsetCurve = CurveTween(curve: AppCurves.slide);
  late Animatable<Offset> _offsetTween;

  @override
  Duration get forwardDuration => widget.duration;

  @override
  void initState() {
    super.initState();

    _offsetTween = Tween(begin: widget.from, end: widget.to).chain(_offsetCurve);

    if (widget.animateOnMount) {
      animationController.forward();

      return;
    }

    animationController.value = animationController.upperBound;
  }

  @override
  void didUpdateWidget(covariant AnimatedTranslation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.from == widget.from && oldWidget.to == widget.to) return;

    _offsetTween = Tween(begin: widget.from, end: widget.to).chain(_offsetCurve);

    animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final offset = _offsetTween.evaluate(animationController);

    return RepaintBoundary(
      child: widget.fractional
          ? FractionalTranslation(
              translation: offset,
              child: widget.child,
            )
          : Transform.translate(
              offset: offset,
              child: widget.child,
            ),
    );
  }
}
