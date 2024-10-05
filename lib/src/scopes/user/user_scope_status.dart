import 'dependencies/user_scope_dependencies.dart';

/// States of user scope initialization flow.
sealed class UserScopeInitStatus {}

final class UserScopeInitActive implements UserScopeInitStatus {
  const UserScopeInitActive();
}

final class UserScopeInitFailed implements UserScopeInitStatus {
  const UserScopeInitFailed();
}

final class UserScopeInitSuccess implements UserScopeInitStatus {
  const UserScopeInitSuccess(this.dependencies);

  final UserScopeDependencies dependencies;
}
