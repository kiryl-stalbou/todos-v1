import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../../utils/common/desktop_constraints.dart';
import '../../../_loading/local/local_loading.dart';
import '../../../_widgets/common/header.dart';
import '../../../_widgets/common/paddings.dart';
import '../../../_widgets/common/spacers.dart';
import '../../../_widgets/interactive/app_button.dart';
import '../../../_widgets/scaffolds/app_scaffold.dart';

class WebScopeInitFailedScreen extends StatelessWidget {
  const WebScopeInitFailedScreen({required this.onReloadTap, super.key});

  final void Function(BuildContext) onReloadTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppScaffold(
      body: Center(
        child: DesktopConstraints(
          child: AppPadding(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Header(
                  icon: Icons.wifi_off_rounded,
                  title: s.key(Lk.scopeInitErrorTitle),
                  subtitle: s.key(Lk.scopeInitErrorSubtitle),
                ),
            
                const VSpacer(Insets.xxxl),
            
                LocalLoading(child: _ReloadButton(onReloadTap)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton(this.onTap);

  final void Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) => AppButton(
        listenLocalLoading: true,
        onTap: () => onTap(context),
        child: Text(S.of(context).key(Lk.tryAgain)),
      );
}
