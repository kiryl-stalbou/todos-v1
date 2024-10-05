import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos/src/entities/user/user_data.dart';
import 'package:todos/src/exceptions/impl/auth_exception.dart';
import 'package:todos/src/scopes/app/dependencies/auth/repository/auth_repository.dart';

final class _UserPasswordWrapper {
  _UserPasswordWrapper({
    required String name,
    required String email,
    required this.password,
  }) : user = UserData(name: name, email: email, id: 'id');

  final UserData user;
  final String password;
  String get name => user.name;
  String get email => user.email;
}

final class MockAuthRepository implements AuthRepository {
  final List<_UserPasswordWrapper> _users = [];

  _UserPasswordWrapper? _currentUser;

  @override
  ValueStream<UserData?> get authStateChanges =>
      _authStateChangesController.stream;

  final _authStateChangesController = BehaviorSubject<UserData?>();

  @override
  Future<void> dispose() => _authStateChangesController.close();

  @override
  Future<void> init() async =>
      _authStateChangesController.add(_currentUser?.user);

  @override
  Future<void> signOut() async =>
      _authStateChangesController.add(_currentUser = null);

  @override
  Future<void> signIn(String email, String password) async {
    final match = _users.firstWhereOrNull(
        (user) => user.email == email && user.password == password);

    if (match == null) throw const AuthException();

    _currentUser = match;
    _authStateChangesController.add(match.user);
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    final match = _users.firstWhereOrNull((user) => user.email == email);

    if (match != null) throw const AuthException();

    _currentUser =
        _UserPasswordWrapper(name: name, email: email, password: password);
    _users.add(_currentUser!);
    _authStateChangesController.add(_currentUser!.user);
  }
}
