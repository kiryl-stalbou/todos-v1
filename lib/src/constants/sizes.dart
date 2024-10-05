import 'package:flutter/material.dart';

abstract final class Insets {
  /// 2
  static const double xxs = 2;

  /// 4
  static const double xs = 4;

  /// 8
  static const double s = 8;

  /// 12
  static const double m = 12;

  /// 16
  static const double l = 16;

  /// 24
  static const double xl = 24;

  /// 32
  static const double xxl = 32;

  /// 40
  static const double xxxl = 40;

  /// 300
  /// Ensures that keyboard doesnt overlap components
  static const double web = 300;
}

abstract final class IconSize {
  /// 128
  static const double xxxl = 128;

  /// 52
  static const double xxl = 52;

  /// 32
  static const double xl = 32;

  /// 28
  static const double l = 28;

  /// 24
  static const double m = 24;

  /// 20
  static const double s = 20;

  /// 16
  static const double xs = 16;
}

abstract final class Indicators {
  /// 40
  static const double xl = 40;

  /// 25
  static const double l = 25;

  /// 10
  static const double m = 10;

  /// 6
  static const double s = 6;
}

abstract final class Strokes {
  /// 3
  static const double thick = 3;

  /// 2
  static const double mid = 2;

  /// 0.4
  static const double thin = 0.4;
}

abstract final class Buttons {
  /// 52
  static const double lHeight = 52;

  /// infinity
  static const double lWidth = double.infinity;

  /// 45
  static const double mHeight = 45;

  /// 150
  static const double mWidth = 150;

  /// 32
  static const double sHeight = 32;

  /// 100
  static const double sWidth = 100;
}

abstract final class Corners {
  /// Radius.circular(24)
  static const Radius lRadius = Radius.circular(24);

  /// BorderRadius.all(Radius.circular(24))
  static const BorderRadius lBorderRadius = BorderRadius.all(lRadius);

  /// BorderRadius.all(Radius.circular(16));
  static const BorderRadius mBorderRadius = BorderRadius.all(Radius.circular(16));

  /// BorderRadius.all(Radius.circular(8));
  static const BorderRadius sBorderRadius = BorderRadius.all(Radius.circular(8));

  /// BorderRadius.all(Radius.circular(4));
  static const BorderRadius xsBorderRadius = BorderRadius.all(Radius.circular(4));

  /// BorderRadius.all(Radius.circular(90));
  static const BorderRadius circular = BorderRadius.all(Radius.circular(90));
}
