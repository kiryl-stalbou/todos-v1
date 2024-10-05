import 'dart:async';

import 'package:flutter/material.dart';

import '../../ui/_init/active/scope_init_active_screen.dart';
import '../../ui/_init/failed/scope_init_failed_screen.dart';
import 'app_scope_status.dart';
import 'dependencies/app_scope_dependencies.dart';
import 'dependencies/app_scope_dependencies_impl.dart';
import 'dependencies/app_scope_dependencies_tree.dart';

class AppScope extends StatefulWidget {
  const AppScope({
    required this.initialized,
    super.key,
  });

  final Widget initialized;

  static AppScopeDependencies dependenciesOf(BuildContext context) {
    final dependencies = context.getInheritedWidgetOfExactType<_AppScopeInheritedWidget>()?.dependencies;

    if (dependencies == null) throw Exception('Invalid context: missing _AppScopeInheritedWidget');

    return dependencies;
  }

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  late Stream<AppScopeInitStatus> _initializer;
  AppScopeDependencies? _dependencies;

  void _resolveInitializer() {
    setState(() => _initializer = AppScopeDependenciesImpl.initializer());
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

  Widget _initialized(AppScopeDependencies dependencies) {
    _dependencies = dependencies;
    return _AppScopeInheritedWidget(
      dependencies: dependencies,
      child: AppScopeDependenciesTree(
        child: widget.initialized,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<AppScopeInitStatus>(
        initialData: const AppScopeInitActive(),
        stream: _initializer,
        builder: (context, snapshot) => switch (snapshot.requireData) {
          AppScopeInitActive() => const ScopeInitActiveScreen(),
          AppScopeInitFailed() => ScopeInitFailedScreen(_resolveInitializer),
          AppScopeInitSuccess(:final dependencies) => _initialized(dependencies),
        },
      );
}

class _AppScopeInheritedWidget extends InheritedWidget {
  const _AppScopeInheritedWidget({
    required this.dependencies,
    required super.child,
  });

  final AppScopeDependencies dependencies;

  @override
  bool updateShouldNotify(_AppScopeInheritedWidget oldWidget) => false;
}
