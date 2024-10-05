import 'package:flutter/material.dart';

import '../../../../constants/fonts.dart';
import '../../../../constants/sizes.dart';
import '../../../../l10n/s.dart';
import '../../../../utils/common/desktop_constraints.dart';
import '../../common/spacers.dart';
import '../../text/resizable_text.dart';

class RawDialog extends StatelessWidget {
  const RawDialog({
    required this.titleLk,
    required this.subtitleLk,
    required this.actions,
    super.key,
  });

  final String titleLk;
  final String subtitleLk;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final dialogTheme = Theme.of(context).dialogTheme;
    final s = S.of(context);

    return Center(
      child: DesktopConstraints(
        maxWidth: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.xxl),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: Corners.lBorderRadius,
              color: dialogTheme.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(Insets.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  ResizableText(
                    s.key(titleLk),
                    maxLines: 2,
                    minFontSize: FontSize.s18,
                    style: dialogTheme.titleTextStyle,
                  ),

                  const VSpacer(Insets.l),

                  Text(s.key(subtitleLk), style: dialogTheme.contentTextStyle),

                  const VSpacer(Insets.l),

                  ...actions,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
