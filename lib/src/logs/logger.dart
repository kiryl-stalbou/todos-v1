import 'dart:developer' as dev show log;

import 'package:flutter/foundation.dart';

final class Logger {
  const Logger({
    required this.library,
    this.method = 'Method Name Not Specified',
    this.params = 'Method Params Not Specified',
  });

  Logger copyWith({required String method, required String params, bool logOnCopy = true}) {
    final l = Logger(library: library, method: method, params: params);

    if (logOnCopy) l.v('Invoked');

    return l;
  }

  /// Verbose level log
  void v(String text) => _log('VERBOSE', text);

  /// Debug level log
  void d(String text) => _log('DEBUG', text);

  /// Info level log
  void i(String text) => _log('INFO', text);

  /// Warning level log
  void w(String text) => _log('WARNING', text);

  /// Fatal level log
  void f(String text) => _log('FATAL', text);

  void error(
    Object exception,
    StackTrace stackTrace, {
    required String reason,
    String? method,
    String? params,
    bool fatal = false,
  }) {
    final msg = _messageFor(fatal ? 'FATAL' : 'ERROR', reason);

    dev.log(msg, error: exception, stackTrace: stackTrace);
  }

  void flutterError(FlutterErrorDetails details, {bool fatal = false}) {
    dev.log('FLUTTER ERROR', error: details.exception, stackTrace: details.stack);
  }

  void _log(String level, String text) {
    final msg = _messageFor(level, text);

    dev.log(msg);
  }

  String _messageFor(String level, String text) => 'LEVEL: $level | LIBRARY: $library | METHOD: $method($params) | MESSAGE: $text';

  final String library;
  final String method;
  final String params;
}
