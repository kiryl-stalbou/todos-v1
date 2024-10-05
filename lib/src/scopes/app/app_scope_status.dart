import 'dependencies/app_scope_dependencies.dart';

/// States of app scope initialization flow.
sealed class AppScopeInitStatus {}

final class AppScopeInitActive implements AppScopeInitStatus {
  const AppScopeInitActive();
}

final class AppScopeInitFailed implements AppScopeInitStatus {
  const AppScopeInitFailed();
}

final class AppScopeInitSuccess implements AppScopeInitStatus {
  const AppScopeInitSuccess(this.dependencies);

  final AppScopeDependencies dependencies;
}
