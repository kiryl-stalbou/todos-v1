import 'package:flutter/material.dart';

import '../../../entities/user/user_data.dart';
import '../../../l10n/lk.dart';
import '../../../scopes/app/dependencies/auth/auth.dart';
import '../../../scopes/user/dependencies/user/user.dart';
import '../../_loading/global/global_loading.dart';

mixin UserProfileController<S extends StatefulWidget> on State<S> {
  late final GlobalLoadingState _globalLoadingState;
  late final AuthState _authState;
  late final UserState _userState;

  UserData get user => _userState.user;

  Future<void> onSignOutTap() => _globalLoadingState.run(
        context,
        _authState.signOut,
        activeLk: Lk.profileSignOutActive,
        successLk: Lk.profileSignOutSuccess,
        failedLk: Lk.profileSignOutFailed,
      );

  @override
  void initState() {
    super.initState();
    _userState = User.of(context);
    _authState = Auth.of(context);
    _globalLoadingState = GlobalLoading.of(context);
  }
}
