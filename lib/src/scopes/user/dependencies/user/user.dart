import 'package:flutter/material.dart';

import '../../../../entities/user/user_data.dart';
import '../../user_scope.dart';
import 'service/user_service.dart';

class User extends StatefulWidget {
  const User({required this.child, super.key});

  final Widget child;

  static UserState of(BuildContext context, {bool listen = false}) {
    UserState? state;

    if (listen) {
      state = context.dependOnInheritedWidgetOfExactType<_UserScope>()?.state;
    } else {
      state = context.getInheritedWidgetOfExactType<_UserScope>()?.state;
    }

    if (state == null) throw Exception('Invalid context: missing _UserInheritedModel');

    return state;
  }

  @override
  State<User> createState() => UserState();
}

class UserState extends State<User> {
  late final UserService _service = UserScope.dependenciesOf(context).userService;

  UserData get user => _service.user;

  @override
  Widget build(BuildContext context) => _UserScope(
        state: this,
        user: user,
        child: widget.child,
      );
}

class _UserScope extends InheritedWidget {
  const _UserScope({
    required this.state,
    required this.user,
    required super.child,
  });

  final UserState state;
  final UserData user;

  @override
  bool updateShouldNotify(_UserScope oldWidget) => oldWidget.user != user;
}
