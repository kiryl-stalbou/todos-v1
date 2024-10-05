import 'package:flutter/material.dart';

import '../../logs/logger.dart';
import '../../ui/auth/signin/signin_screen.dart';
import '../../ui/auth/signup/signup_screen.dart';
import '../_pages/material_page.dart';
import 'auth_configuration.dart';

class AuthRouterDelegate extends RouterDelegate<AuthConfiguration> with ChangeNotifier {
  AuthRouterDelegate() : _navigatorKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigatorKey;

  static const _l = Logger(library: 'AuthRouterDelegate');

  bool _showSignUpScreen = false;
  bool get showSignUpScreen => _showSignUpScreen;
  set showSignUpScreen(bool value) {
    _showSignUpScreen = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: _navigatorKey,
        onPopPage: _handleNavigatorPop,
        clipBehavior: Clip.none,
        pages: <Page<void>>[
          //
          asMaterialPage(const SignInScreen(), 'SignInScreen'),

          if (_showSignUpScreen) asMaterialPage(const SignUpScreen(), 'SignUpScreen'),
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

  bool _tryPopRoute() {
    if (_showSignUpScreen) {
      showSignUpScreen = false;
      return true;
    }

    return false;
  }

  @override
  AuthConfiguration? get currentConfiguration => AuthConfiguration(
        showSignUp: _showSignUpScreen,
      );

  @override
  Future<void> setInitialRoutePath(AuthConfiguration configuration) async {
    final l = _l.copyWith(method: 'setInitialRoutePath', params: 'configuration: $configuration');

    await setNewRoutePath(configuration);

    l.v('Completed');
  }

  @override
  Future<void> setNewRoutePath(AuthConfiguration configuration) async {
    final l = _l.copyWith(method: 'setNewRoutePath', params: 'configuration: $configuration');

    showSignUpScreen = configuration.showSignUp;

    l.v('Completed');
  }
}
