import 'dart:async' show FutureOr;

import 'package:flutter/material.dart' show BuildContext;

import 'impl/_app_exception.dart';

/// Contains either result of async operation or exception if throws.
typedef EitherFuture<R> = Future<(AppException?, R?)>;

/// If [fn] completes without error returns `(null, R)` and
/// if [then.context] is mounted, runs [then.fn] if provided.
///
/// Otherwise returns `(AppException, null)`.
EitherFuture<R> tryCatchEither<R>({
  required FutureOr<R> Function() fn,
  (BuildContext context, FutureOr<void> Function() fn)? then,
}) async {
  try {
    final data = await fn();

    if (then != null && then.$1.mounted) await then.$2();

    return (null, data);
  } on AppException catch (e) {
    return (e, null);
  }
}

/// If [fn] completes without error returns `R`
///
/// Otherwise returns `null`.
Future<R?> tryCatch<R>({
  required FutureOr<R> Function() fn,
  (BuildContext context, FutureOr<void> Function() fn)? then,
}) async {
  try {
    final data = await fn();

    if (then != null && then.$1.mounted) await then.$2();

    return data;
  } on AppException {
    return null;
  }
}
