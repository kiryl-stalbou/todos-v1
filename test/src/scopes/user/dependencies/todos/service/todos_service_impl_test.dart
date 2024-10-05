import 'package:flutter_test/flutter_test.dart';
import 'package:todos/src/entities/todo/todo_data.dart';
import 'package:todos/src/scopes/user/dependencies/todos/service/todos_service_impl.dart';

import 'todos_service_impl_test.mocks.dart';

void main() {
  late MockTodosRepository mockTodosRepository;
  late TodosServiceImpl todosServiceImpl;

  const empttodos = <TodoData>[];

  const defaultTodo1 = TodoData(
      id: '1', title: null, notes: null, date: null, isCompleted: false);
  const defaultTodo2 = TodoData(
      id: '2', title: null, notes: null, date: null, isCompleted: false);
  final todayTodo = TodoData(
      id: '3',
      title: null,
      notes: null,
      date: DateTime.now(),
      isCompleted: false);
  const completedTodo = TodoData(
      id: '4', title: null, notes: null, date: null, isCompleted: true);
  const unknownTodo = TodoData(
      id: '5', title: null, notes: null, date: null, isCompleted: false);

  setUp(() async {
    mockTodosRepository = MockTodosRepository();
    await mockTodosRepository.init();
    todosServiceImpl = TodosServiceImpl(mockTodosRepository);
    await todosServiceImpl.init();
  });
  tearDown(() async {
    await todosServiceImpl.dispose();
  });

  group('TodosServiceImpl', () {
    test('init, should emit empty lists via every todos streams', () {
      expect(todosServiceImpl.allTodosStream, emits(empttodos));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));
    });

    test(
        'create, should create new todo, add emit it '
        'via appropriate stream', () {
      expect(() => todosServiceImpl.create(defaultTodo1), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([defaultTodo1]));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.create(todayTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([defaultTodo1, todayTodo]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.create(completedTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([defaultTodo1, todayTodo]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));
    });

    test(
        'move, should move todo to the specified position '
        'and emit a new todos via appropriate stream. '
        'If any of the specified todos not found do nothing', () {
      expect(() => todosServiceImpl.create(defaultTodo1), returnsNormally);
      expect(() => todosServiceImpl.create(completedTodo), returnsNormally);
      expect(() => todosServiceImpl.create(todayTodo), returnsNormally);
      expect(() => todosServiceImpl.create(defaultTodo2), returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([defaultTodo1, todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move forward
      expect(() => todosServiceImpl.move(defaultTodo1, defaultTodo2),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([todayTodo, defaultTodo2, defaultTodo1]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move backward
      expect(() => todosServiceImpl.move(defaultTodo1, todayTodo),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([defaultTodo1, todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move nothing
      expect(
          () => todosServiceImpl.move(todayTodo, todayTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([defaultTodo1, todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move from center
      expect(() => todosServiceImpl.move(todayTodo, defaultTodo1),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([todayTodo, defaultTodo1, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move from unknown
      expect(() => todosServiceImpl.move(unknownTodo, defaultTodo1),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([todayTodo, defaultTodo1, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      // Move to unknown
      expect(() => todosServiceImpl.move(defaultTodo1, unknownTodo),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([todayTodo, defaultTodo1, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));
    });

    test(
        'delete, should delete todo and emit '
        'a new todos via appropriate stream. '
        'If the specified todo not found do nothing', () {
      expect(() => todosServiceImpl.create(defaultTodo1), returnsNormally);
      expect(() => todosServiceImpl.create(todayTodo), returnsNormally);
      expect(() => todosServiceImpl.create(defaultTodo2), returnsNormally);
      expect(() => todosServiceImpl.create(completedTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream,
          emits([defaultTodo1, todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      expect(() => todosServiceImpl.delete(defaultTodo1), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      expect(() => todosServiceImpl.delete(completedTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([todayTodo, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.delete(todayTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.delete(defaultTodo2), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits(empttodos));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.delete(unknownTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits(empttodos));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));
    });

    test(
        'update, should update todo with new specified todo '
        'and emit a new todos via appropriate stream. '
        'If the specified todo not found do nothing', () {
      expect(() => todosServiceImpl.create(defaultTodo1), returnsNormally);
      expect(() => todosServiceImpl.create(defaultTodo2), returnsNormally);

      expect(
          todosServiceImpl.allTodosStream, emits([defaultTodo1, defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits(empttodos));

      expect(() => todosServiceImpl.update(defaultTodo1, completedTodo),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([defaultTodo2]));
      expect(todosServiceImpl.todatodosStream, emits(empttodos));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      expect(() => todosServiceImpl.update(defaultTodo2, todayTodo),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([todayTodo]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      expect(
          () => todosServiceImpl.update(todayTodo, todayTodo), returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([todayTodo]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));

      expect(() => todosServiceImpl.update(unknownTodo, completedTodo),
          returnsNormally);

      expect(todosServiceImpl.allTodosStream, emits([todayTodo]));
      expect(todosServiceImpl.todatodosStream, emits([todayTodo]));
      expect(todosServiceImpl.completedTodosStream, emits([completedTodo]));
    });
  });
}
