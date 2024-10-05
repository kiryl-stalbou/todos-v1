import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../entities/user/user_data.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../_widgets/common/spacers.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({required this.user, super.key});

  final UserData user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          Text(
            '${s.key(Lk.name)}: ${user.name}',
            style: textTheme.titleSmall,
          ),

          const VSpacer(Insets.l),

          Text(
            '${s.key(Lk.email)}: ${user.email}',
            textAlign: TextAlign.center,
            style: textTheme.titleSmall,
          ),
        ],
      );
  }
}
