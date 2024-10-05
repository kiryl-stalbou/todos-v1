import 'package:rxdart/rxdart.dart' show ValueStream;

import '../../../../../entities/user/user_data.dart';

abstract interface class AuthService {
  ValueStream<UserData?> get authStateChanges;

  Future<void> dispose();

  Future<void> signOut();

  Future<void> signIn(String email, String password);

  Future<void> signUp(String name, String email, String password);
}
