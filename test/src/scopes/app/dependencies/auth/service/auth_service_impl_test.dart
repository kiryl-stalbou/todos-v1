import 'package:flutter_test/flutter_test.dart';
import 'package:todos/src/entities/user/user_data.dart';
import 'package:todos/src/exceptions/impl/auth_exception.dart';
import 'package:todos/src/scopes/app/dependencies/auth/service/auth_service_impl.dart';

import 'auth_service_impl_test.mocks.dart';

void main() {
  group('AuthServiceImpl', () {
    late AuthServiceImpl authServiceImpl;
    late MockAuthRepository mockAuthRepository;
    const testUser = UserData(name: 'name', email: 'email', id: 'id');
    const testPassword = 'password';

    setUp(() async {
      mockAuthRepository = MockAuthRepository();
      await mockAuthRepository.init();
      authServiceImpl = AuthServiceImpl(mockAuthRepository);
    });
    tearDown(() async {
      await authServiceImpl.dispose();
    });

    test(
        'init, if user is not signed in should emit null '
        'via authStateChanges', () {
      expect(authServiceImpl.authStateChanges, emits(null));
    });

    test(
        'signIn, if user exists should emit him via authStateChanges, '
        'otherwise should throw AuthException', () async {
      expect(() async => authServiceImpl.signIn(testUser.email, testPassword),
          throwsA(const AuthException()));

      await authServiceImpl.signUp(testUser.name, testUser.email, testPassword);

      expect(authServiceImpl.authStateChanges, emits(testUser));

      expect(() async => authServiceImpl.signIn(testUser.email, testPassword),
          returnsNormally);

      expect(authServiceImpl.authStateChanges, emits(testUser));
    });

    test(
        'signUp, if user exists should throw AuthException, '
        'otherwise should emit him via authStateChanges', () async {
      expect(
          () async => authServiceImpl.signUp(
              testUser.name, testUser.email, testPassword),
          returnsNormally);

      expect(authServiceImpl.authStateChanges, emits(testUser));

      expect(
          () async => authServiceImpl.signUp(
              testUser.name, testUser.email, testPassword),
          throwsA(const AuthException()));
    });

    test(
        'signOut, if user is signed in should emit null via '
        'authStateChanges, otherwise do nothing', () async {
      expect(
          () async => authServiceImpl.signUp(
              testUser.name, testUser.email, testPassword),
          returnsNormally);

      expect(() async => authServiceImpl.signOut(), returnsNormally);

      expect(() async => authServiceImpl.signOut(), returnsNormally);
    });
  });
}
