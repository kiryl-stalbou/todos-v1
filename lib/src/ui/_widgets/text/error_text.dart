import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../common/spacers.dart';
import 'overflow_text.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(
    this.text, {
    this.opacity = 1,
    super.key,
  });

  final String text;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Icon(
          CupertinoIcons.exclamationmark_circle_fill,
          color: colorScheme.error.withOpacity(opacity),
        ),

        const HSpacer(Insets.xs),

        OverflowText(
          text,
          maxLines: 1,
          fit: FlexFit.loose,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withOpacity(opacity)),
        ),
      ],
    );
  }
}
