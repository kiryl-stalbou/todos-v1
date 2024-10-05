import 'package:flutter/material.dart';

import '../../../scopes/user/dependencies/todos/todos.dart';

class TodayBadge extends StatelessWidget {
  const TodayBadge({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final stream = Todos.of(context).todatodosStream;

    return StreamBuilder(
      initialData: stream.valueOrNull,
      stream: stream,
      builder: (_, snapshot) {
        final count = snapshot.data?.length ?? 0;

        return Badge.count(
          count: count,
          isLabelVisible: count > 0,
          child: child,
        );
      },
    );
  }
}
