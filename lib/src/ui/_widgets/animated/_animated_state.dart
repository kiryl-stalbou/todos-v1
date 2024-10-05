import 'package:flutter/material.dart';

const Duration _defaultDuration = Duration(milliseconds: 300);

abstract class AnimatedState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin<T> {
  late final AnimationController _animationController;
  AnimationController get animationController => _animationController;

  Duration get forwardDuration => _defaultDuration;
  Duration get reversedDuration => forwardDuration;

  void _onAnimationValueChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: forwardDuration,
      reverseDuration: reversedDuration,
    );
    _animationController.addListener(_onAnimationValueChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


abstract class AnimatedBuilderState1<S extends StatefulWidget> extends State<S> with SingleTickerProviderStateMixin<S> {
  late final AnimationController _animationController;
  AnimationController get animationController => _animationController;

  Duration get forwardDuration => _defaultDuration;
  Duration get reversedDuration => forwardDuration;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: forwardDuration,
      reverseDuration: reversedDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

abstract class AnimatedBuilderState2<S extends StatefulWidget> extends State<S> with TickerProviderStateMixin<S> {
  late final AnimationController _animationController1;
  late final AnimationController _animationController2;
  AnimationController get animationController1 => _animationController1;
  AnimationController get animationController2 => _animationController2;

  Duration get forwardDuration1 => _defaultDuration;
  Duration get reversedDuration1 => forwardDuration1;

  Duration get forwardDuration2 => _defaultDuration;
  Duration get reversedDuration2 => forwardDuration2;

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      duration: forwardDuration1,
      reverseDuration: reversedDuration1,
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: forwardDuration2,
      reverseDuration: reversedDuration2,
    );
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    super.dispose();
  }
}
