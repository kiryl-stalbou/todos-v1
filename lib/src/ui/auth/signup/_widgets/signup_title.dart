import 'package:flutter/material.dart';

import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return Text(
      s.key(Lk.signup),
      style: textTheme.titleLarge,
    );
  }
}
