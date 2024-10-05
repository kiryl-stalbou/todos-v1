import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../entities/todo/todo_data.dart';
import '../../../../../exceptions/impl/todo_exception.dart';
import '../../../../../logs/logger.dart';
import 'todos_repository.dart';

final class TodosRepositoryImpl implements TodosRepository {
  TodosRepositoryImpl(this._uid);

  final String _uid;

  static const _l = Logger(library: 'TodosRepositoryImpl');
  static const _todosKey = 'todos';

  FirebaseFirestore get _db => FirebaseFirestore.instance;
  DocumentReference<Map<String, Object?>> get _docRef => _db.collection('users_todos').doc(_uid);

  final _todosController = BehaviorSubject<List<TodoData>>();
  late final StreamSubscription<DocumentSnapshot<Map<String, Object?>>> _todosSubscription;

  @override
  ValueStream<List<TodoData>> get todosStream => _todosController.stream;

  @override
  Future<void> init() async {
    final l = _l.copyWith(method: 'init', params: '');

    _todosSubscription = _docRef.snapshots().listen(_onTodosChanges);

    l.v('Completed');
  }

  @override
  Future<void> dispose() async {
    final l = _l.copyWith(method: 'dispose', params: '');

    await _todosSubscription.cancel();
    await _todosController.close();

    l.v('Completed');
  }

  @override
  Future<void> update(List<TodoData> todos) async {
    final l = _l.copyWith(method: 'update', params: 'todos: $todos');
    try {
      final jsons = todos.map((e) => e.toJson());

      // Set operation will complete only if write has reached backend, so we cant
      // wait for it in offline mode, but it will instantly write to locale firestore storage
      // and when user will go online next time this pending write will be processed
      //
      // ignore: unawaited_futures
      _docRef.set({_todosKey: jsons});

      l.v('Todos was updated');
    } on FirebaseException catch (e, s) {
      l.error(e, e.stackTrace ?? s, reason: 'Failed to update todos to Firestore');

      throw TodoException(code: e.code);
    }
  }

  void _onTodosChanges(DocumentSnapshot<Map<String, Object?>> docs) {
    final l = _l.copyWith(method: '_onTodosChanges', params: 'docs: $docs');

    final list = docs.data()?[_todosKey] as List<Object?>?;

    final todos = <TodoData>[];

    if (list != null) {
      for (final e in list) {
        final json = e as Map<String, Object?>?;
        if (json != null) todos.add(TodoData.fromJson(json));
      }
    }

    l.v('Completed with $todos');

    _todosController.add(todos);
  }
}
