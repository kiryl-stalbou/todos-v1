import 'package:flutter/material.dart';

import '_raw_dialog.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    required this.titleLk,
    required this.subtitleLk,
    required this.actions,
    super.key,
  });

  final String titleLk;
  final String subtitleLk;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => RawDialog(
        titleLk: titleLk,
        subtitleLk: subtitleLk,
        actions: actions,
      );
}
