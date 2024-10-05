import 'package:flutter/material.dart' show Curve, Curves;

abstract final class AppCurves {
  static const Curve scale = Curves.bounceOut;

  static const Curve buttonShrink = Curves.linear;

  static const Curve autoScroll = Curves.easeOutCirc;

  static const Curve expansion = Curves.fastOutSlowIn;

  static const Curve fade = Curves.fastOutSlowIn;

  static const Curve rotate = Curves.easeInOut;

  static const Curve checkbox = Curves.easeIn;

  static const Curve slide = Curves.easeOutQuad;

  static const Curve shake = Curves.linear;

  static const Curve themeChange = Curves.linear;
}
