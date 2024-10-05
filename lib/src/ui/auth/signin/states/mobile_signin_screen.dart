import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../../utils/mixins/theme_state_mixin.dart';
import '../../../_widgets/appbars/static_appbar.dart';
import '../../../_widgets/common/hide_keyboard_area.dart';
import '../../../_widgets/common/spacers.dart';
import '../../../_widgets/interactive/bottom_button.dart';
import '../../../_widgets/scaffolds/app_scaffold.dart';
import '../_widgets/signin_form.dart';
import '../_widgets/signin_title.dart';
import '../_widgets/signup_button.dart';
import '../signin_controller.dart';

class MobileSignInScreen extends StatefulWidget {
  const MobileSignInScreen({super.key});

  @override
  State<MobileSignInScreen> createState() => _MobileSignInScreenState();
}

class _MobileSignInScreenState extends State<MobileSignInScreen> with SignInControllerMixin, LocalizationStateMixin, ThemeStateMixin {
  @override
  Widget build(BuildContext context) => AppScaffold(
        resizeToAvoidBottomInset: true,
        top: const StaticAppBar(),
        bottom: _SignInButton(onSignInTap),
        body: HideKeyboardArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              const SignInTitle(),

              const VSpacer(Insets.l),

              SignInForm(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),

              const VSpacer(Insets.xl),

              SignUpButton(onSignUpTap),
            ],
          ),
        ),
      );
}

class _SignInButton extends StatelessWidget {
  const _SignInButton(this.onTap);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BottomButton(
      onTap: onTap,
      child: Text(s.key(Lk.signinButton)),
    );
  }
}
