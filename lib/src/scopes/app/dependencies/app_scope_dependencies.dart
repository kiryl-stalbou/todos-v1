import 'auth/service/auth_service.dart';

/// Dirty class which initialize all app scope dependencies.
abstract interface class AppScopeDependencies {
  AuthService get authService;

  /// Dispose all [AppScopeDependencies]
  void dispose();
}
