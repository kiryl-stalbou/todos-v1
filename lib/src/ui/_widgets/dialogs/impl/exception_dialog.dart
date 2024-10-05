import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../interactive/app_button.dart';
import '_raw_dialog.dart';

class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog({
    required this.titleLk,
    required this.subtitleLk,
    super.key,
  });

  final String titleLk;
  final String subtitleLk;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return RawDialog(
      titleLk: titleLk,
      subtitleLk: subtitleLk,
      actions: [
        AppButton(
          onTap: () => Navigator.of(context).pop(),
          height: Buttons.mHeight,
          borderRadius: Corners.sBorderRadius,
          child: Text(
            s.key(Lk.ok),
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
