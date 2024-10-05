import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/durations.dart';
import '../../_loading/local/local_loading.dart';
import 'states/mobile_scope_init_failed_screen.dart';
import 'states/web_scope_init_failed_screen.dart';

class ScopeInitFailedScreen extends StatelessWidget {
  const ScopeInitFailedScreen(this.onReloadTap, {super.key});

  final VoidCallback onReloadTap;

  Future<void> _onReloadTap(BuildContext context) async {
    await LocalLoading.wait(context, Future<void>.delayed(AppDurations.aestheticDelay));

    if (context.mounted) onReloadTap();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return WebScopeInitFailedScreen(onReloadTap: _onReloadTap);

    return MobileScopeInitFailedScreen(onReloadTap: _onReloadTap);
  }
}
