import 'package:flutter/widgets.dart';

import 'todos/todos.dart';
import 'user/user.dart';

class UserScopeDependenciesTree extends StatelessWidget {
  const UserScopeDependenciesTree({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => User(
        child: Todos(
          child: child,
        ),
      );
}
