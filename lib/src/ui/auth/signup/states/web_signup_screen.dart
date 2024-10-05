import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../../utils/common/desktop_constraints.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../../utils/mixins/theme_state_mixin.dart';
import '../../../_widgets/appbars/scroll_aware_appbar.dart';
import '../../../_widgets/common/hide_keyboard_area.dart';
import '../../../_widgets/common/paddings.dart';
import '../../../_widgets/common/spacers.dart';
import '../../../_widgets/interactive/app_button.dart';
import '../../../_widgets/scaffolds/scroll_aware_scaffold.dart';
import '../_widgets/signin_button.dart';
import '../_widgets/signin_form.dart';
import '../_widgets/signup_title.dart';
import '../signup_controller.dart';

class WebSignUpScreen extends StatefulWidget {
  const WebSignUpScreen({super.key});

  @override
  State<WebSignUpScreen> createState() => _WebSignUpScreenState();
}

class _WebSignUpScreenState extends State<WebSignUpScreen> with SignUpControllerMixin, LocalizationStateMixin, ThemeStateMixin {
  @override
  Widget build(BuildContext context) => ScrollAwareScaffold(
        top: ScrollAwareAppBar(
          title: Text(s.key(Lk.signup)),
          showTitleScrollExtent: 70,
        ),
        body: HideKeyboardArea(
          child: ListView(
            children: [
              //
              const VSpacer(Insets.xxl),

              const Center(child: SignUpTitle()),

              const VSpacer(Insets.l),

              Center(
                child: DesktopConstraints(
                  child: SignUpForm(
                    formKey: formKey,
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
              ),

              const VSpacer(Insets.xl),

              Center(child: SignInButton(onSignInTap)),

              const VSpacer(Insets.xxxl),

              Center(
                child: DesktopConstraints(
                  child: _SignUpButton(onSignUpTap),
                ),
              ),

              const VSpacer(Insets.web),
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

    return AppButton(
      onTap: onTap,
      margin: AppPadding.horizontal,
      child: Text(s.key(Lk.signupButton)),
    );
  }
}
