import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'todo_route_information_parser.dart';
import 'todo_router_delegate.dart';

class TodoRouter extends StatefulWidget {
  const TodoRouter({super.key});

  static TodoRouterDelegate of(BuildContext context) {
    final delegate = context.getInheritedWidgetOfExactType<_TodoRouterInheritedWidget>()?.routerDelegate;

    if (delegate == null) throw Exception('Invalid context: Missing _TodoRouterInheritedWidget');

    return delegate;
  }

  @override
  State<TodoRouter> createState() => _TodoRouterState();
}

class _TodoRouterState extends State<TodoRouter> {
  late final _routerDelegate = TodoRouterDelegate();
  late final _routeInformationParser = TodoRouteInformationParser();
  late final _routeInformationProvider = PlatformRouteInformationProvider(
    initialRouteInformation: RouteInformation(
      uri: Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName),
    ),
  );
  late final _backButtonDispatcher = RootBackButtonDispatcher();

  @override
  Widget build(BuildContext context) => _TodoRouterInheritedWidget(
        routerDelegate: _routerDelegate,
        child: Router(
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
          routeInformationProvider: _routeInformationProvider,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
}

class _TodoRouterInheritedWidget extends InheritedWidget {
  const _TodoRouterInheritedWidget({
    required this.routerDelegate,
    required super.child,
  });

  final TodoRouterDelegate routerDelegate;

  @override
  bool updateShouldNotify(_TodoRouterInheritedWidget oldWidget) => false;
}
