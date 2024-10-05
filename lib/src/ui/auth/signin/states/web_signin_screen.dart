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
import '../_widgets/signin_form.dart';
import '../_widgets/signin_title.dart';
import '../_widgets/signup_button.dart';
import '../signin_controller.dart';

class WebSignInScreen extends StatefulWidget {
  const WebSignInScreen({super.key});

  @override
  State<WebSignInScreen> createState() => _WebSignInScreenState();
}

class _WebSignInScreenState extends State<WebSignInScreen> with SignInControllerMixin, LocalizationStateMixin, ThemeStateMixin {
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

              const Center(child: SignInTitle()),

              const VSpacer(Insets.l),

              Center(
                child: DesktopConstraints(
                  child: SignInForm(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
              ),

              const VSpacer(Insets.xl),

              Center(child: SignUpButton(onSignUpTap)),

              const VSpacer(Insets.xxxl),

              Center(
                child: DesktopConstraints(
                  child: _SignInButton(onSignInTap),
                ),
              ),

              const VSpacer(Insets.web),
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

    return AppButton(
      onTap: onTap,
      margin: AppPadding.horizontal,
      child: Text(s.key(Lk.signinButton)),
    );
  }
}
