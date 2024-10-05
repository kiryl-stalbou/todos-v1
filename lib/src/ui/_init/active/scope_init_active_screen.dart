import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'states/mobile_scope_init_active_screen.dart';
import 'states/web_scope_init_active_screen.dart';

class ScopeInitActiveScreen extends StatelessWidget {
  const ScopeInitActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const WebScopeInitActiveScreen();

    return const MobileScopeInitActiveScreen();
  }
}
