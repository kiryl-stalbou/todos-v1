import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../entities/todo/todo_data.dart';
import '../../../../../exceptions/impl/todo_exception.dart';
import '../../../../../logs/logger.dart';
import '../repository/todos_repository.dart';
import 'todos_service.dart';

final class TodosServiceImpl implements TodosService {
  TodosServiceImpl(this._repository);

  final TodosRepository _repository;

  static const _l = Logger(library: 'TodosServiceImpl');

  final _completedTodosController = BehaviorSubject<List<TodoData>>();
  final _todatodosController = BehaviorSubject<List<TodoData>>();
  final _allTodosController = BehaviorSubject<List<TodoData>>();
  late final StreamSubscription<List<TodoData>> _todosSubscription;

  List<TodoData> _lastKnownTodos = [];

  @override
  ValueStream<List<TodoData>> get allTodosStream => _allTodosController.stream;

  @override
  ValueStream<List<TodoData>> get completedTodosStream =>
      _completedTodosController.stream;

  @override
  ValueStream<List<TodoData>> get todatodosStream =>
      _todatodosController.stream;

  @override
  Future<void> init() async {
    final l = _l.copyWith(method: 'init', params: '');

    _todosSubscription = _repository.todosStream.listen(_onTodosChanges);

    l.v('Completed');
  }

  @override
  Future<void> dispose() async {
    final l = _l.copyWith(method: 'dispose', params: '');

    await _todosSubscription.cancel();
    await _completedTodosController.close();
    await _todatodosController.close();
    await _allTodosController.close();

    l.v('Completed');
  }

  @override
  void create(TodoData todo) {
    final l = _l.copyWith(method: 'create', params: 'todo: $todo');

    final todos = _repository.todosStream.valueOrNull;

    if (todos == null) {
      l.w('Failed to create todo, last emited todos not found');
      return;
    }

    todos.add(todo);

    // ignore: discarded_futures
    _update(todos);

    l.v('Completed');
  }

  @override
  void move(TodoData from, TodoData to) {
    final l = _l.copyWith(method: 'move', params: 'from: $from, to: $to');

    final todos = _repository.todosStream.valueOrNull;

    if (todos == null) {
      l.w('Failed to move todo, last emited todos not found');
      return;
    }

    final toIndex = todos.indexOf(to);

    if (toIndex == -1) {
      l.w('Failed to move todo, toTodo not found');
      return;
    }

    final isRemoved = todos.remove(from);

    if (!isRemoved) {
      l.w('Failed to move todo, fromTodo todo not found');
      return;
    }

    todos.insert(toIndex, from);

    // ignore: discarded_futures
    _update(todos);

    l.v('Move was successfull');
  }

  @override
  void delete(TodoData todo) {
    final l = _l.copyWith(method: 'delete', params: 'todo: $todo');

    final todos = _repository.todosStream.valueOrNull;

    if (todos == null) {
      l.w('Failed to delete todo, last emited todos not found');
      return;
    }

    final isRemoved = todos.remove(todo);

    if (!isRemoved) {
      l.w('Failed to delete todo, target todo not found');
      return;
    }

    // ignore: discarded_futures
    _update(todos);

    l.v('Delete was successfull');
  }

  @override
  void update(TodoData oldTodo, TodoData newTodo) {
    final l = _l.copyWith(
        method: 'update', params: 'oldTodo: $oldTodo, newTodo: $newTodo');

    if (oldTodo == newTodo) {
      l.i('Todo is up to date');
      return;
    }

    final todos = _repository.todosStream.valueOrNull;

    if (todos == null) {
      l.w('Failed to update todo, last emited todos not found');
      return;
    }

    final oldIndex = todos.indexOf(oldTodo);

    if (oldIndex == -1) {
      l.w('Failed to update todo, oldTodo not found');
      return;
    }

    todos[oldIndex] = newTodo;

    // ignore: discarded_futures
    _update(todos);

    l.v('Update was successfull');
  }

  Future<void> _update(List<TodoData> todos) async {
    final l = _l.copyWith(method: '_update', params: '');
    try {
      // Dont wait for update from server
      _onTodosChanges(todos);

      await _repository.update(todos);

      l.v('Completed');
    } on TodoException catch (e, s) {
      l.error(e, s, reason: 'Failed to update todos');
      // Since firebase automatically will retry next time when user goes online
      // we dont need to manage this scenario, so we just silence any exception
    }
  }

  void _onTodosChanges(List<TodoData> todos) {
    final l = _l.copyWith(method: '_onTodosChanges', params: 'todos: $todos');

    // If todos is empty we need to pass it further,
    // to differenciate loading state and absence of data
    if (todos.isNotEmpty && _listEquals(_lastKnownTodos, todos)) {
      l.v('Todos is up to date, nothing to update');
      return;
    }

    _lastKnownTodos = List.of(todos);

    final allTodos = <TodoData>[];
    final todatodos = <TodoData>[];
    final completedTodos = <TodoData>[];

    for (final todo in todos) {
      if (todo.isCompleted) {
        completedTodos.add(todo);
      } else {
        if (_isToday(todo.date)) todatodos.add(todo);
        allTodos.add(todo);
      }
    }

    _allTodosController.add(allTodos);
    _todatodosController.add(todatodos);
    _completedTodosController.add(completedTodos);

    l.v('Completed with all: $allTodos today: $todatodos, completed: $completedTodos');
  }
}

bool _isToday(DateTime? date) {
  if (date == null) return false;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final shortDate = DateTime(date.year, date.month, date.day);
  return shortDate.isAtSameMomentAs(today);
}

bool Function(List<TodoData>?, List<TodoData>?) _listEquals =
    const ListEquality<TodoData>().equals;
