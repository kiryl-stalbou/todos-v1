/// Base class for all app custom [Exception]'s
abstract base class AppException implements Exception {
  const AppException({String? code}) : code = code ?? 'code-not-specified';

  final String code;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppException && code == other.code;

  @override
  int get hashCode => Object.hashAll([code]);

  @override
  String toString() => 'AppException{code: $code}';
}
