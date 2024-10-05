import '_app_exception.dart';

final class TodoException extends AppException {
  const TodoException({super.code});

  @override
  String toString() => 'TodoException{code: $code}';
}
