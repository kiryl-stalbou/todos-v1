import '../../../constants/durations.dart';
import '../../../entities/user/user_data.dart';
import '../../../exceptions/impl/_app_exception.dart';
import '../../../logs/logger.dart';

import '../../../utils/common/initialization_time.dart';
import '../user_scope_status.dart';
import 'todos/repository/todos_repository.dart';
import 'todos/repository/todos_repository_impl.dart';
import 'todos/service/todos_service.dart';
import 'todos/service/todos_service_impl.dart';
import 'user/service/user_service.dart';
import 'user/service/user_service_impl.dart';
import 'user_scope_dependencies.dart';

final class UserScopeDependenciesImpl implements UserScopeDependencies {
  const UserScopeDependenciesImpl._(this.userService, this.todosService);

  @override
  final UserService userService;

  @override
  final TodosService todosService;

  static const _l = Logger(library: 'UserScopeDependenciesImpl');

  static Stream<UserScopeInitStatus> initializer(UserData user) async* {
    final l = _l.copyWith(method: 'initializer', params: 'user: $user');

    UserService? userService;

    TodosRepository? todosRepository;
    TodosService? todosService;

    final watch = Stopwatch()..start();

    try {
      yield const UserScopeInitActive();

      // ---- DEPENDENCIES INITIALIZATION STARTED ----
      userService = UserServiceImpl(user);

      todosRepository = TodosRepositoryImpl(user.id);
      await todosRepository.init();
      todosService = TodosServiceImpl(todosRepository);
      await todosService.init();
      // ---- DEPENDENCIES INITIALIZATION FINISHED ----

      final dependencies = UserScopeDependenciesImpl._(userService, todosService);

      await stopInitWatch(AppDurations.minUserScopeInitDelay, watch, l);

      yield UserScopeInitSuccess(dependencies);

      l.v('Initialization Completed');
    } on AppException catch (e, s) {
      l.error(e, s, reason: 'Initialization Failed');

      await todosService?.dispose();
      await todosRepository?.dispose();

      await stopInitWatch(AppDurations.minAppScopeInitDelay, watch, l);

      yield const UserScopeInitFailed();
    }
  }

  @override
  void dispose() {
    final l = _l.copyWith(method: 'dispose', params: '');

    // ignore: discarded_futures
    todosService.dispose();

    l.v('Completed');
  }
}
