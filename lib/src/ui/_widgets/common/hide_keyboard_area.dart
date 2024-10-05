import 'package:flutter/material.dart';

import '../../../utils/common/hide_keyboard.dart';

class HideKeyboardArea extends StatelessWidget {
  const HideKeyboardArea({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: hideKeyBoard,
        child: child,
      );
}
