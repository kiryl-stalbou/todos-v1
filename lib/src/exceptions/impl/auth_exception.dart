import '_app_exception.dart';

final class AuthException extends AppException {
  const AuthException({super.code});

  @override
  String toString() => 'AuthException{code: $code}';
}
