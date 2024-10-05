import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'auth_route_information_parser.dart';
import 'auth_router_delegate.dart';

class AuthRouter extends StatefulWidget {
  const AuthRouter({super.key});

  static AuthRouterDelegate of(BuildContext context) {
    final delegate = context.getInheritedWidgetOfExactType<_AuthRouterInheritedWidget>()?.routerDelegate;

    if (delegate == null) throw Exception('Invalid context: Missing _AuthRouterInheritedWidget');

    return delegate;
  }

  @override
  State<AuthRouter> createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  late final _routerDelegate = AuthRouterDelegate();
  late final _routeInformationParser = AuthRouteInformationParser();
  late final _routeInformationProvider = PlatformRouteInformationProvider(
    initialRouteInformation: RouteInformation(
      uri: Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName),
    ),
  );
  late final _backButtonDispatcher = RootBackButtonDispatcher();

  @override
  Widget build(BuildContext context) => _AuthRouterInheritedWidget(
        routerDelegate: _routerDelegate,
        child: Router(
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
          routeInformationProvider: _routeInformationProvider,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
}

class _AuthRouterInheritedWidget extends InheritedWidget {
  const _AuthRouterInheritedWidget({
    required this.routerDelegate,
    required super.child,
  });

  final AuthRouterDelegate routerDelegate;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
