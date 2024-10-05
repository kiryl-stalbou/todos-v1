import 'package:flutter/cupertino.dart';

import '../../../l10n/lk.dart';
import '../../../routing/auth/auth_router.dart';
import '../../../scopes/app/dependencies/auth/auth.dart';
import '../../../utils/common/text_validators.dart';
import '../../_loading/global/global_loading.dart';
import '../../_widgets/interactive/validatable/validatable_form.dart';

mixin SignUpControllerMixin<S extends StatefulWidget> on State<S> {
  late final GlobalLoadingState _globalLoadingState;
  late final AuthState _authState;

  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  final formKey = GlobalKey<ValidatableFormState>();

  Future<void> onSignUpTap() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final name = clearSpaces(nameController.text);
    final email = clearSpaces(emailController.text);
    final password = clearSpaces(passwordController.text);

    await _globalLoadingState.run(
      context,
      () => _authState.signUp(name, email, password),
      activeLk: Lk.signupActive,
      successLk: Lk.signupSuccess,
      failedLk: Lk.signupFailed,
    );
  }

  void onSignInTap() => AuthRouter.of(context).showSignUpScreen = false;

  @override
  void initState() {
    super.initState();
    _authState = Auth.of(context);
    _globalLoadingState = GlobalLoading.of(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
