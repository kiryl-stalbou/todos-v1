import 'package:flutter/material.dart';

Page<void> asNoTransitionPage(Widget w, String name) => NoTransitionPage(
      name: name,
      key: ValueKey(name),
      child: w,
    );

class NoTransitionPage extends Page<void> {
  const NoTransitionPage({
    required this.child,
    super.name,
    super.key,
  });

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) => _PageBasedNoTransitionPageRoute(page: this);
}

class _PageBasedNoTransitionPageRoute extends PageRoute<void> {
  _PageBasedNoTransitionPageRoute({
    required NoTransitionPage page,
  }) : super(settings: page) {
    assert(opaque);
  }

  NoTransitionPage get _page => settings as NoTransitionPage;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  bool get maintainState => true;

  @override
  bool get fullscreenDialog => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => _page.child;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => child;
}
