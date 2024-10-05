import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../common/spacers.dart';
import '../common/three_children_layout.dart';

class StaticAppBar extends StatelessWidget {
  const StaticAppBar({
    this.title,
    this.actions,
    this.titleSpacing,
    super.key,
  });

  final Widget? title;
  final List<Widget>? actions;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    Widget? title = this.title;
    if (title != null) {
      title = DefaultTextStyle(
        style: appBarTheme.titleTextStyle ?? const TextStyle(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        child: title,
      );
    }

    final implyBackButton = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;

    return ColoredBox(
      color: appBarTheme.backgroundColor ?? AppColors.red,
      child: SafeArea(
        child: SizedBox(
          height: appBarTheme.toolbarHeight,
          child: ThreeChildrenLayout(
            middleSpacing: titleSpacing,
            leading: implyBackButton ? const BackButton() : null,
            middle: title,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                ...?actions,

                const _ToggleLanguageButton(),

                const _ToggleThemeButton(),

                const HSpacer(Insets.s),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToggleLanguageButton extends StatelessWidget {
  const _ToggleLanguageButton();

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: S.of(context).key(Lk.toggleLanguage),
        onPressed: () => TodoLocalizations.toggle(context),
        icon: const Icon(Icons.language),
      );
}

class _ToggleThemeButton extends StatelessWidget {
  const _ToggleThemeButton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      tooltip: S.of(context).key(Lk.toggleTheme),
      onPressed: () => TodoTheme.toggle(context),
      icon: Icon(isDark ? Icons.sunny : CupertinoIcons.moon_fill),
    );
  }
}
