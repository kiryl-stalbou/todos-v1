import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../constants/sizes.dart';
import '../../../entities/todo/todo_data.dart';
import '../../../scopes/user/dependencies/todos/todos.dart';
import '../../_widgets/common/hide_keyboard_area.dart';
import '../../_widgets/common/spacers.dart';
import '../../_widgets/indicators/circular_loading_indicator.dart';
import 'todo_card.dart';
import 'todos_title.dart';

class TodosStream extends StatelessWidget {
  const TodosStream({
    required this.mode,
    required this.title,
    required this.stream,
    super.key,
  });

  final String title;
  final ValueNotifier<TodoCardMode?> mode;
  final ValueStream<List<TodoData>> stream;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<TodoData>>(
        initialData: stream.valueOrNull,
        stream: stream,
        builder: (_, snapshot) {
          final todos = snapshot.data;

          if (todos == null) {
            return const Center(child: CircularLoadingIndicator(dimension: Indicators.xl));
          }

          return HideKeyboardArea(
            child: CustomScrollView(
              slivers: [
                //
                TodosTitle(title),

                const VSpacer.sliver(Insets.l),

                SliverReorderableList(
                  itemCount: todos.length,
                  itemBuilder: (_, index) => TodoCard(
                    key: ValueKey(todos[index].id),
                    todo: todos[index],
                    index: index,
                    mode: mode,
                  ),
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) newIndex -= 1;
                    Todos.of(context).move(todos[oldIndex], todos[newIndex]);
                    // Update local to prevent lag
                    final item = todos.removeAt(oldIndex);
                    todos.insert(newIndex, item);
                  },
                  proxyDecorator: (child, _, __) => ColoredBox(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: child,
                  ),
                ),

                const VSpacer.sliver(Insets.web),
              ],
            ),
          );
        },
      );
}
