import 'package:rxdart/rxdart.dart';

import '../../../../../entities/todo/todo_data.dart';

abstract interface class TodosService {
  Future<void> init();

  Future<void> dispose();

  void create(TodoData todo);

  void update(TodoData oldTodo, TodoData newTodo);

  void move(TodoData from, TodoData to);

  void delete(TodoData todo);

  ValueStream<List<TodoData>> get allTodosStream;

  ValueStream<List<TodoData>> get todatodosStream;

  ValueStream<List<TodoData>> get completedTodosStream;
}
