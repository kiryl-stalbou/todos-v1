import 'dart:math' show pi, sin;

import 'package:flutter/material.dart';

import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../constants/sizes.dart';
import '../../../utils/mixins/localization_state_mixin.dart';
import '../../../utils/mixins/theme_state_mixin.dart';
import '../common/spacers.dart';
import '../text/error_text.dart';
import '_animated_state.dart';

const int _shakeCount = 4;
const double _shakeOffset = Insets.m;

class AnimatedErrorText extends StatefulWidget {
  const AnimatedErrorText({
    required this.child,
    required this.margin,
    required this.errorLk,
    super.key,
  });

  final Widget child;
  final EdgeInsets margin;
  final String? errorLk;

  @override
  State<AnimatedErrorText> createState() => _AnimatedErrorTextState();
}

class _AnimatedErrorTextState extends AnimatedBuilderState2<AnimatedErrorText> with ThemeStateMixin, LocalizationStateMixin {
  late final Animatable<double> _shakeTween;
  late final Animatable<double> _heightTween;

  String? _errorLk;

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController1.reset();
    }
  }

  @override
  Duration get forwardDuration1 => AppDurations.shake;

  @override
  Duration get forwardDuration2 => AppDurations.slide;

  @override
  void initState() {
    super.initState();

    final shakeCurve = CurveTween(curve: AppCurves.shake);
    final slideCurve = CurveTween(curve: AppCurves.slide);

    _shakeTween = Tween<double>(begin: 0, end: 1).chain(shakeCurve);
    _heightTween = Tween<double>(begin: 0, end: 1).chain(slideCurve);

    animationController1.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void didUpdateWidget(covariant AnimatedErrorText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.errorLk == widget.errorLk) return;

    if (widget.errorLk != null) {
      _errorLk = widget.errorLk;
      animationController1.forward();
      animationController2.forward();
    } else {
      animationController2.reverse();
    }
  }

  double get _shakeXOffset => _shakeOffset * sin(2 * pi * _shakeCount * _shakeTween.evaluate(animationController1));
  double get _heightFactor => _heightTween.evaluate(animationController2);

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            AnimatedBuilder(
              animation: animationController1,
              builder: (_, child) => Transform.translate(offset: Offset(_shakeXOffset, 0), child: child),
              child: Padding(
                padding: widget.margin,
                child: widget.child,
              ),
            ),

            if (_errorLk != null) ...[
              //
              const VSpacer(Insets.xs),

              Padding(
                padding: widget.margin,
                child: AnimatedBuilder(
                  animation: animationController2,
                  builder: (_, __) => Align(
                    alignment: Alignment.topLeft,
                    heightFactor: _heightFactor,
                    child: ErrorText(
                      s.key('$_errorLk'),
                      opacity: _heightFactor,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
}
