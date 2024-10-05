import 'package:flutter/material.dart';

mixin ThemeStateMixin<T extends StatefulWidget> on State<T> {
  late ThemeData _theme;

  ThemeData get theme => _theme;
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  bool get isLightTheme => _theme.brightness == Brightness.light;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }
}
