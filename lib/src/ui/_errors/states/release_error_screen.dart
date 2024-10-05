import 'package:flutter/cupertino.dart';

import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../../_widgets/common/header.dart';
import '../../_widgets/scaffolds/app_scaffold.dart';

class ReleaseErrorScreen extends StatelessWidget {
  const ReleaseErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppScaffold(
      body: Center(
        child: Header(
          icon: CupertinoIcons.exclamationmark_circle,
          title: s.key(Lk.errorReleaseTitle),
          subtitle: s.key(Lk.errorReleaseBody),
        ),
      ),
    );
  }
}
