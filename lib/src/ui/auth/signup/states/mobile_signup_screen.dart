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
import '../_widgets/signin_button.dart';
import '../_widgets/signin_form.dart';
import '../_widgets/signup_title.dart';
import '../signup_controller.dart';

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({super.key});

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> with SignUpControllerMixin, LocalizationStateMixin, ThemeStateMixin {
  @override
  Widget build(BuildContext context) => AppScaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindBottom: true,
        top: const StaticAppBar(),
        bottom: _SignUpButton(onSignUpTap),
        body: HideKeyboardArea(
          child: ListView(
            children: [
              //
              const VSpacer(Insets.xxl),

              const Center(child: SignUpTitle()),

              const VSpacer(Insets.l),

              SignUpForm(
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
              ),

              const VSpacer(Insets.xl),

              Center(child: SignInButton(onSignInTap)),
            ],
          ),
        ),
      );
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton(this.onTap);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BottomButton(
      onTap: onTap,
      fadeBackground: true,
      child: Text(s.key(Lk.signupButton)),
    );
  }
}
