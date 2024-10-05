import 'package:flutter_test/flutter_test.dart';
import 'package:todos/src/entities/user/user_data.dart';
import 'package:todos/src/scopes/user/dependencies/user/service/user_service_impl.dart';

void main() {
  late UserServiceImpl userServiceImpl;
  late UserData testUser;

  group('UserServiceImpl, getter', () {
    setUp(() {
      testUser = const UserData(name: 'test', email: 'test@gmail.com', id: '1');
      userServiceImpl = UserServiceImpl(testUser);
    });

    test('User getter', () {
      expect(userServiceImpl.user, testUser);
    });
  });
}
