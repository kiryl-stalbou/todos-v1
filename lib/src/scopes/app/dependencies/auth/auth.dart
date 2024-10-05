import 'package:flutter/material.dart';

import '../../../../entities/user/user_data.dart';
import '../../../../exceptions/try_catch.dart';
import '../../app_scope.dart';
import 'service/auth_service.dart';

class Auth extends StatefulWidget {
  const Auth({required this.unauthenticated, required this.authenticated, super.key});

  final Widget unauthenticated;
  final Widget Function(UserData user) authenticated;

  static AuthState of(BuildContext context) {
    AuthState? state;

    state = context.getInheritedWidgetOfExactType<_AuthScope>()?.state;

    if (state == null) throw Exception('Invalid context: missing _AuthScope');

    return state;
  }

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  late final AuthService _service = AppScope.dependenciesOf(context).authService;

  EitherFuture<void> signIn(String email, String password) => tryCatchEither(
        fn: () => _service.signIn(email, password),
      );

  EitherFuture<void> signUp(String name, String email, String password) => tryCatchEither(
        fn: () => _service.signUp(name, email, password),
      );

  EitherFuture<void> signOut() => tryCatchEither(
        fn: _service.signOut,
      );

  @override
  Widget build(BuildContext context) => _AuthScope(
        state: this,
        child: StreamBuilder<UserData?>(
          initialData: _service.authStateChanges.valueOrNull,
          stream: _service.authStateChanges,
          builder: (context, snapshot) {
            final user = snapshot.data;

            if (user == null) return widget.unauthenticated;

            return widget.authenticated(user);
          },
        ),
      );
}

class _AuthScope extends InheritedWidget {
  const _AuthScope({
    required super.child,
    required this.state,
  });

  final AuthState state;

  @override
  bool updateShouldNotify(_AuthScope oldWidget) => false;
}
