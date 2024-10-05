import 'package:rxdart/rxdart.dart' show ValueStream;

import '../../../../../entities/user/user_data.dart';
import '../../../../../logs/logger.dart';
import '../repository/auth_repository.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl(this._repository);

  final AuthRepository _repository;

  static const _l = Logger(library: 'AuthServiceImpl');

  @override
  ValueStream<UserData?> get authStateChanges => _repository.authStateChanges;

  @override
  Future<void> dispose() async {
    final l = _l.copyWith(method: 'dispose', params: '');

    await _repository.dispose();

    l.v('Completed');
  }

  @override
  Future<void> signOut() async {
    final l = _l.copyWith(method: 'signOut', params: '');

    await _repository.signOut();

    l.i('Completed');
  }

  @override
  Future<void> signIn(String email, String password) async {
    final l = _l.copyWith(method: 'signIn', params: '');

    await _repository.signIn(email, password);

    l.i('Completed');
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    final l = _l.copyWith(method: 'signUp', params: '');

    await _repository.signUp(name, email, password);

    l.i('Completed');
  }
}
