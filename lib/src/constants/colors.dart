import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color transparent = Colors.transparent;
  static const Color disabled = Color.fromARGB(255, 177, 177, 176);
  static const Color barrierColor = Color(0x80000000);

  static const Color white = Colors.white;
  static const Color white26 = Color.fromARGB(66, 255, 255, 255);
  static const Color beige = Color.fromARGB(255, 241, 239, 235);

  static const Color black = Colors.black;
  static const Color black26 = Colors.black26;
  static const Color black38 = Colors.black38;

  static const Color grey = Color.fromARGB(255, 147, 146, 143);
  static const Color grey26 = Color.fromARGB(66, 147, 146, 143);

  static const Color red = Colors.red;
  static const Color red8 = Color.fromARGB(21, 244, 67, 54);
  static const Color red38 = Color.fromARGB(102, 244, 67, 54);

  static const Color green = Color(0xff4e8f2c);
  static const Color green42 = Color.fromARGB(120, 121, 204, 25);

  static const Color blue = Colors.blue;
  static const Color blue26 = Color.fromARGB(66, 33, 149, 243);
}

abstract final class Shadows {
  static const List<BoxShadow> top = [
    BoxShadow(
      color: AppColors.black26,
      offset: Offset.zero,
      spreadRadius: 0,
      blurRadius: 15,
    ),
  ];
}
