import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'states/desktop_todo_tabs.dart';
import 'states/mobile_todo_tabs.dart';

class TodoTabs extends StatelessWidget {
  const TodoTabs({super.key});

  @override
  Widget build(BuildContext context) => !kIsWeb
      ? const MobileTodoTabs()
      : LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth < 600) {
              return const MobileTodoTabs();
            }
            return const DesktopTodoTabs();
          },
        );
}
