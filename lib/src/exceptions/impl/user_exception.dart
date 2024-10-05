import '_app_exception.dart';

final class UserException extends AppException {
  const UserException({super.code});

  @override
  String toString() => 'UserException{code: $code}';
}
