import 'package:flutter/material.dart';

import '../../constants/curves.dart';
import '../../constants/durations.dart';

Future<void> ensureTextFieldVisible(BuildContext context, [FocusNode? focusNode]) async {
  // Wait for keyboard animatinon
  await Future<void>.delayed(const Duration(milliseconds: 600));

  if (context.mounted && (focusNode?.hasFocus ?? true)) {
    await Scrollable.ensureVisible(
      context,
      alignment: 0.55,
      curve: AppCurves.autoScroll,
      duration: AppDurations.autoScroll,
    );
  }
}
