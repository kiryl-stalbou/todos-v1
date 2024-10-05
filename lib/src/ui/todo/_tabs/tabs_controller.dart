import 'package:flutter/material.dart';

import '../../../routing/todo/todo_configuration.dart';
import '../../../routing/todo/todo_router.dart';
import '../../../routing/todo/todo_router_delegate.dart';
import '../all_todos/all_todos_screen.dart';
import '../completed_todos/completed_todos_screen.dart';
import '../today_todos/today_todos_screen.dart';
import '../user_profile/user_profile_screen.dart';

const tabsViews = <Widget>[
  AllTodosScreen(),
  CompletedTodosScreen(),
  TodatodosScreen(),
  UserProfileScreen(),
];

mixin TodoTabsController<S extends StatefulWidget> on State<S> {
  late final TodoRouterDelegate _routerDelegate;

  int get selectedTabIndex => _routerDelegate.selectedTab.value.index;

  void onTabTap(int index) =>
      _routerDelegate.selectedTab.value = TodoTab.values[index];

  void _onTabChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _routerDelegate = TodoRouter.of(context);
    _routerDelegate.selectedTab.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _routerDelegate.selectedTab.removeListener(_onTabChanged);
    super.dispose();
  }
}
