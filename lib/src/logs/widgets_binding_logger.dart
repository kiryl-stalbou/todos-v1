import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'logger.dart';

final class WidgetsBindingLogger with WidgetsBindingObserver {
  const WidgetsBindingLogger();

  static const _l = Logger(library: 'WidgetsBindingLogger');

  @override
  Future<bool> didPopRoute() async {
    final l = _l.copyWith(method: 'didPopRoute', params: '');

    final didPop = await super.didPopRoute();

    l.v('didPop: $didPop');

    return didPop;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) async {
    final l = _l.copyWith(method: 'didPushRouteInformation', params: 'routeInformation: ${routeInformation.uri}');

    final didPush = await super.didPushRouteInformation(routeInformation);

    l.v('didPush: $didPush');

    return didPush;
  }

  // @override
  // void didChangeMetrics() {
  //   _l.copyWith(method: 'didChangeMetrics', params: '');

  //   super.didChangeMetrics();
  // }

  @override
  void didChangeTextScaleFactor() {
    _l.copyWith(method: 'didChangeTextScaleFactor', params: '');

    super.didChangeTextScaleFactor();
  }

  @override
  void didChangePlatformBrightness() {
    _l.copyWith(method: 'didChangePlatformBrightness', params: '');

    super.didChangePlatformBrightness();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    _l.copyWith(method: 'didChangeLocales', params: 'locales: $locales');

    super.didChangeLocales(locales);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _l.copyWith(method: 'didChangeAppLifecycleState', params: 'state: $state');

    super.didChangeAppLifecycleState(state);
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    final l = _l.copyWith(method: 'didRequestAppExit', params: '');

    final response = await super.didRequestAppExit();

    l.v('response: $response');

    return response;
  }

  @override
  void didHaveMemoryPressure() {
    _l.copyWith(method: 'didHaveMemoryPressure', params: '');

    super.didHaveMemoryPressure();
  }

  @override
  void didChangeAccessibilityFeatures() {
    _l.copyWith(method: 'didChangeAccessibilityFeatures', params: '');

    super.didChangeAccessibilityFeatures();
  }
}
