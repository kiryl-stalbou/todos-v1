import 'dart:async';

import 'package:flutter/material.dart';

import '../../entities/user/user_data.dart';
import '../../ui/_init/active/scope_init_active_screen.dart';
import '../../ui/_init/failed/scope_init_failed_screen.dart';
import 'dependencies/user_scope_dependencies.dart';
import 'dependencies/user_scope_dependencies_impl.dart';
import 'dependencies/user_scope_dependencies_tree.dart';
import 'user_scope_status.dart';

class UserScope extends StatefulWidget {
  UserScope({
    required this.user,
    required this.initialized,
  }) : super(key: ValueKey(user));

  final UserData user;
  final Widget initialized;

  static UserScopeDependencies dependenciesOf(BuildContext context) {
    final dependencies = context.getInheritedWidgetOfExactType<_UserScopeInheritedWidget>()?.dependencies;

    if (dependencies == null) throw Exception('Invalid context: missing _userScopeInheritedWidget');

    return dependencies;
  }

  @override
  State<UserScope> createState() => _UserScopeState();
}

class _UserScopeState extends State<UserScope> {
  late Stream<UserScopeInitStatus> _initializer;
  UserScopeDependencies? _dependencies;

  void _resolveInitializer() {
    setState(() => _initializer = UserScopeDependenciesImpl.initializer(widget.user));
  }

  @override
  void initState() {
    super.initState();
    _resolveInitializer();
  }

  @override
  void dispose() {
    _dependencies?.dispose();
    super.dispose();
  }

  Widget _initialized(UserScopeDependencies dependencies) {
    _dependencies = dependencies;
    return _UserScopeInheritedWidget(
      dependencies: dependencies,
      child: UserScopeDependenciesTree(
        child: widget.initialized,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<UserScopeInitStatus>(
        stream: _initializer,
        initialData: const UserScopeInitActive(),
        builder: (context, snapshot) => switch (snapshot.requireData) {
          UserScopeInitActive() => const ScopeInitActiveScreen(),
          UserScopeInitFailed() => ScopeInitFailedScreen(_resolveInitializer),
          UserScopeInitSuccess(:final dependencies) => _initialized(dependencies),
        },
      );
}

class _UserScopeInheritedWidget extends InheritedWidget {
  const _UserScopeInheritedWidget({
    required this.dependencies,
    required super.child,
  });

  final UserScopeDependencies dependencies;

  @override
  bool updateShouldNotify(_UserScopeInheritedWidget oldWidget) => false;
}
