import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fir;
import 'package:rxdart/rxdart.dart';

import '../../../../../entities/user/user_data.dart';
import '../../../../../exceptions/impl/auth_exception.dart';
import '../../../../../logs/logger.dart';
import 'auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  static const _l = Logger(library: 'AuthRepositoryImpl');

  late final StreamSubscription<fir.User?> _firAuthStateChangesSubscription;
  late final BehaviorSubject<UserData?> _authStateChanges;

  fir.FirebaseAuth get _firAuth => fir.FirebaseAuth.instance;

  @override
  ValueStream<UserData?> get authStateChanges => _authStateChanges.stream;

  @override
  Future<void> init() async {
    final l = _l.copyWith(method: 'init', params: '');

    _authStateChanges = BehaviorSubject<UserData?>();
    _firAuthStateChangesSubscription = _firAuth.authStateChanges().listen(_onFirAuthStateChanges);

    l.v('Completed');
  }

  @override
  Future<void> dispose() async {
    final l = _l.copyWith(method: 'dispose', params: '');

    await _firAuthStateChangesSubscription.cancel();
    await _authStateChanges.close();

    l.v('Completed');
  }

  @override
  Future<void> signOut() async {
    assert(_firAuth.currentUser != null, 'User must be signed in');
    final l = _l.copyWith(method: 'signOut', params: '');
    try {
      await _firAuth.signOut();

      l.i('Successfully signedOut user');
    } on fir.FirebaseException catch (e, s) {
      l.error(e, e.stackTrace ?? s, reason: 'Failed to signOut user');

      throw AuthException(code: e.code);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    assert(_firAuth.currentUser == null, 'User must be signed out');
    final l = _l.copyWith(method: 'signIn', params: 'email: $email, password: $password');
    try {
      await _firAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      l.i('Successfully signedIn user');
    } on fir.FirebaseException catch (e, s) {
      l.error(e, e.stackTrace ?? s, reason: 'Failed to signIn User');

      throw AuthException(code: e.code);
    }
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    assert(_firAuth.currentUser == null, 'User must be signed out');
    final l = _l.copyWith(method: 'signUp', params: 'name: $name, email: $email, password: $password');
    try {
      final credential = await _firAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);
      await credential.user?.reload();

      _onFirAuthStateChanges(_firAuth.currentUser);

      l.i('Successfully signedUp user');
    } on fir.FirebaseException catch (e, s) {
      l.error(e, e.stackTrace ?? s, reason: 'Failed to signUp user');

      throw AuthException(code: e.code);
    }
  }

  void _onFirAuthStateChanges(fir.User? firUser) {
    final l = _l.copyWith(method: '_onFirUserAuthStateChanges', params: 'firUser: $firUser');

    if (firUser == null) {
      l.i('User is not Signed In');

      _authStateChanges.add(null);

      return;
    }

    final username = firUser.displayName;
    final email = firUser.email;
    final id = firUser.uid;

    if (email != null) {
      if (username == null) {
        l.i('User is Successfully Signed In, waiting for username update');

        return;
      }

      l.i('User is Successfully Signed In');

      final user = UserData(name: username, email: email, id: id);

      _authStateChanges.add(user);

      return;
    }

    assert(false, 'Failed to handle fir auth state changes, invalid user data');
    l.f('Failed to handle fir auth state changes, invalid user data');
  }
}
