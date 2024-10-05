import 'package:flutter/material.dart';

import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../../../scopes/user/dependencies/todos/todos.dart';
import '../../_widgets/appbars/scroll_aware_appbar.dart';
import '../../_widgets/scaffolds/app_scaffold.dart';
import '../_widgets/todo_card.dart';
import '../_widgets/todos_menu.dart';
import '../_widgets/todos_stream.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  final _todosCardsMode = ValueNotifier<TodoCardMode?>(null);

  @override
  void dispose() {
    _todosCardsMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppScaffold(
      top: ScrollAwareAppBar(
        showTitleScrollExtent: 25,
        title: Text(s.key(Lk.completed)),
        actions: [TodosMenu(mode: _todosCardsMode)],
      ),
      body: TodosStream(
        mode: _todosCardsMode,
        title: s.key(Lk.completed),
        stream: Todos.of(context).completedTodosStream,
      ),
    );
  }
}
