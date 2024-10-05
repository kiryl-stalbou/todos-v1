import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../common/spacers.dart';
import '../../interactive/app_button.dart';
import '_raw_dialog.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    required this.titleLk,
    required this.subtitleLk,
    required this.confirmLk,
    super.key,
  });

  final String titleLk;
  final String subtitleLk;
  final String confirmLk;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return RawDialog(
      titleLk: titleLk,
      subtitleLk: subtitleLk,
      actions: [
        //
        AppButton(
          onTap: () => Navigator.of(context).pop(true),
          height: Buttons.mHeight,
          borderRadius: Corners.sBorderRadius,
          child: Text(
            s.key(confirmLk),
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
          ),
        ),

        const VSpacer(Insets.s),

        AppButton(
          onTap: () => Navigator.of(context).pop(false),
          height: Buttons.mHeight,
          borderRadius: Corners.sBorderRadius,
          color: colorScheme.tertiary.withOpacity(0.75),
          child: Text(
            s.key(Lk.cancel),
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
