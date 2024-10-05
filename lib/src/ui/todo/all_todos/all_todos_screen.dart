import 'package:flutter/material.dart';

import '../../../entities/todo/todo_data.dart';
import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../../../scopes/user/dependencies/todos/todos.dart';
import '../../../utils/common/unique_id.dart';
import '../../_widgets/appbars/scroll_aware_appbar.dart';
import '../../_widgets/scaffolds/app_scaffold.dart';
import '../_widgets/todo_card.dart';
import '../_widgets/todos_menu.dart';
import '../_widgets/todos_stream.dart';

class AllTodosScreen extends StatefulWidget {
  const AllTodosScreen({super.key});

  @override
  State<AllTodosScreen> createState() => _AllTodosScreenState();
}

class _AllTodosScreenState extends State<AllTodosScreen> {
  final _todosCardsMode = ValueNotifier<TodoCardMode?>(null);

  void _onAddTodoTap() => Todos.of(context).create(
        TodoData(
          id: generateUniqueId(),
          title: null,
          notes: null,
          date: null,
          isCompleted: false,
        ),
      );

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
        title: Text(s.key(Lk.all)),
        actions: [
          TodosMenu(
            mode: _todosCardsMode,
            onAddTodoTap: _onAddTodoTap,
          ),
        ],
      ),
      body: TodosStream(
        title: s.key(Lk.all),
        mode: _todosCardsMode,
        stream: Todos.of(context).allTodosStream,
      ),
    );
  }
}
