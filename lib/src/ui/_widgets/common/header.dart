import 'package:flutter/material.dart';

import '../../../constants/fonts.dart';
import '../../../constants/sizes.dart';
import '../text/resizable_text.dart';
import 'spacers.dart';

class Header extends StatelessWidget {
  const Header({
    required this.title,
    required this.subtitle,
    this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xxxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (icon != null) ...[
            //
            Icon(
              icon,
              size: IconSize.xxxl,
            ),

            const VSpacer(Insets.l),
          ],

          ResizableText(
            title,
            maxLines: 1,
            minFontSize: FontSize.s18,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(fontSize: FontSize.s26, height: 1),
          ),

          const VSpacer(Insets.s),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(height: 1),
          ),
        ],
      ),
    );
  }
}
