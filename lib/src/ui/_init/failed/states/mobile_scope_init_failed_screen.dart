import 'package:flutter/material.dart';

import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../_loading/local/local_loading.dart';
import '../../../_widgets/common/header.dart';
import '../../../_widgets/interactive/bottom_button.dart';
import '../../../_widgets/scaffolds/app_scaffold.dart';

class MobileScopeInitFailedScreen extends StatelessWidget {
  const MobileScopeInitFailedScreen({required this.onReloadTap, super.key});

  final void Function(BuildContext) onReloadTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppScaffold(
      extendBodyBehindBottom: true,
      bottom: LocalLoading(child: _ReloadButton(onReloadTap)),
      body: Center(
        child: Header(
          icon: Icons.wifi_off_rounded,
          title: s.key(Lk.scopeInitErrorTitle),
          subtitle: s.key(Lk.scopeInitErrorSubtitle),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton(this.onTap);

  final void Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) => BottomButton(
        listenLocalLoading: true,
        onTap: () => onTap(context),
        child: Text(S.of(context).key(Lk.tryAgain)),
      );
}
