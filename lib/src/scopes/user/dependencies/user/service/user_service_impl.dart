import '../../../../../entities/user/user_data.dart';

import 'user_service.dart';

final class UserServiceImpl implements UserService {
  UserServiceImpl(this._user);

  final UserData _user;

  @override
  UserData get user => _user;
}
