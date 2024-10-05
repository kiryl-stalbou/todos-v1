import 'package:flutter/material.dart';

import '../../logs/logger.dart';

import 'auth_configuration.dart';

class AuthRouteInformationParser extends RouteInformationParser<AuthConfiguration> {
  static const _l = Logger(library: 'AuthRouteInformationParser');

  @override
  Future<AuthConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final l = _l.copyWith(method: 'parseRouteInformation', params: 'routeInformation: ${routeInformation.uri}');

    final configuration = AuthConfiguration.fromUri(routeInformation.uri);

    l.v('Completed with: $configuration');

    return configuration;
  }

  @override
  RouteInformation? restoreRouteInformation(AuthConfiguration configuration) {
    final l = _l.copyWith(method: 'restoreRouteInformation', params: 'configuration: $configuration');

    final routeInformation = RouteInformation(uri: configuration.toUri());

    l.v('Completed with: ${routeInformation.uri}');

    return routeInformation;
  }
}
