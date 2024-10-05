import 'package:flutter/material.dart';

mixin Focus1StateMixin<S extends StatefulWidget> on State<S> {
  late final FocusNode _focusNode = FocusNode(debugLabel: 'FocusStateMixin', canRequestFocus: canRequestFocus);

  bool get canRequestFocus => true;

  FocusNode get focusNode => _focusNode;

  bool get hasFocus => _focusNode.hasFocus;

  void onFocusChanged() {}

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
