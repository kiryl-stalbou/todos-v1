import 'package:flutter/material.dart';

class WebScopeInitActiveScreen extends StatelessWidget {
  const WebScopeInitActiveScreen({super.key});

  @override
  // On the web we dont need to show any loading
  Widget build(BuildContext context) => ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: const Center(),
      );
}
