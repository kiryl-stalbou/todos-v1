import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../entities/todo/todo_data.dart';

import '../../user_scope.dart';
import 'service/todos_service.dart';

class Todos extends StatefulWidget {
  const Todos({required this.child, super.key});

  final Widget child;

  static TodosState of(BuildContext context) {
    final state = context.getInheritedWidgetOfExactType<_TodoScope>()?.state;

    if (state == null) throw Exception('Invalid context: missing _TodoScope');

    return state;
  }

  @override
  State<Todos> createState() => TodosState();
}

class TodosState extends State<Todos> {
  late final TodosService _service =
      UserScope.dependenciesOf(context).todosService;

  void create(TodoData todo) => _service.create(todo);

  void update(TodoData oldTodo, TodoData newTodo) =>
      _service.update(oldTodo, newTodo);

  void move(TodoData from, TodoData to) => _service.move(from, to);

  void delete(TodoData todo) => _service.delete(todo);

  ValueStream<List<TodoData>> get allTodosStream => _service.allTodosStream;

  ValueStream<List<TodoData>> get todatodosStream => _service.todatodosStream;

  ValueStream<List<TodoData>> get completedTodosStream =>
      _service.completedTodosStream;

  @override
  Widget build(BuildContext context) => _TodoScope(
        state: this,
        child: widget.child,
      );
}

class _TodoScope extends InheritedWidget {
  const _TodoScope({
    required this.state,
    required super.child,
  });

  final TodosState state;

  @override
  bool updateShouldNotify(_TodoScope oldWidget) => false;
}
