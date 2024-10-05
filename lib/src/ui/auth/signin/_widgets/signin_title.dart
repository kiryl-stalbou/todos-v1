import 'package:flutter/material.dart';

import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';

class SignInTitle extends StatelessWidget {
  const SignInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return Text(
      s.key(Lk.signin),
      style: textTheme.titleLarge,
    );
  }
}
