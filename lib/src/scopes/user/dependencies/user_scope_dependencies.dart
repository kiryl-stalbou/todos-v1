import 'todos/service/todos_service.dart';
import 'user/service/user_service.dart';

/// Dirty class that initialize all user scope dependencies.
abstract interface class UserScopeDependencies {
  UserService get userService;

  TodosService get todosService;

  /// Dispose all [UserScopeDependencies]
  void dispose();
}
