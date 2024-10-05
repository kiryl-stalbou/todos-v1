import 'package:flutter/material.dart';

import '../../logs/logger.dart';
import '../../ui/todo/_tabs/todo_tabs.dart';
import '../_pages/no_transition_page.dart';
import 'todo_configuration.dart';

class TodoRouterDelegate extends RouterDelegate<TodoConfiguration> with ChangeNotifier {
  TodoRouterDelegate() : _navigatorKey = GlobalKey() {
    selectedTab.addListener(notifyListeners);
  }

  final GlobalKey<NavigatorState> _navigatorKey;

  static const _l = Logger(library: 'TodoRouterDelegate');

  ValueNotifier<TodoTab> selectedTab = ValueNotifier(TodoTab.all);

  @override
  void dispose() {
    selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        onPopPage: _handleNavigatorPop,
        clipBehavior: Clip.none,
        key: _navigatorKey,
        pages: <Page<void>>[
          //
          asNoTransitionPage(const TodoTabs(), 'TodoScreen'),
        ],
      );

  bool _handleNavigatorPop(Route<void> route, void result) {
    if (route.didPop(result)) return _tryPopRoute();

    return false;
  }

  @override
  Future<bool> popRoute() async {
    final navigator = _navigatorKey.currentState;

    if (navigator == null) return false;

    return navigator.maybePop();
  }

  bool _tryPopRoute() => false;

  @override
  TodoConfiguration? get currentConfiguration => TodoConfiguration(selectedTab: selectedTab.value);

  @override
  Future<void> setInitialRoutePath(TodoConfiguration configuration) async {
    final l = _l.copyWith(method: 'setInitialRoutePath', params: 'configuration: $configuration');

    await setNewRoutePath(configuration);

    l.v('Completed');
  }

  @override
  Future<void> setNewRoutePath(TodoConfiguration configuration) async {
    final l = _l.copyWith(method: 'setNewRoutePath', params: 'configuration: $configuration');

    selectedTab.value = configuration.selectedTab;

    l.v('Completed');
  }
}
