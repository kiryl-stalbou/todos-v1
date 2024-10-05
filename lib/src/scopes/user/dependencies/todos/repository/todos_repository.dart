import 'package:rxdart/rxdart.dart';

import '../../../../../entities/todo/todo_data.dart';

abstract interface class TodosRepository {
  Future<void> init();

  Future<void> dispose();

  Future<void> update(List<TodoData> todos);

  ValueStream<List<TodoData>> get todosStream;
}
