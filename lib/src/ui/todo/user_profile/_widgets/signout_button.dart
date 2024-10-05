import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../_widgets/interactive/app_button.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final s = S.of(context);

    return AppButton(
      onTap: onTap,
      color: AppColors.red8,
      disabledColor: AppColors.red8,
      splashColor: AppColors.red38,
      child: Text(
        s.key(Lk.signout),
        style: TextStyle(color: colorScheme.error),
      ),
    );
  }
}
