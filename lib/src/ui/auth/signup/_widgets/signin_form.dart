import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../l10n/s.dart';
import '../../../../utils/common/text_validators.dart';
import '../../../_widgets/common/paddings.dart';
import '../../../_widgets/common/spacers.dart';
import '../../../_widgets/interactive/validatable/validatable_form.dart';
import '../../../_widgets/interactive/validatable/validatable_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final Key formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return ValidatableForm(
      key: formKey,
      child: Column(
        children: [
          //
          ValidatableTextField(
            controller: nameController,
            margin: AppPadding.horizontal,
            validator: TextValidator.notEmpty,
            label: s.key(Lk.name),
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.person_rounded,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),

          const VSpacer(Insets.l),

          ValidatableTextField(
            maxLength: 320,
            controller: emailController,
            margin: AppPadding.horizontal,
            validator: TextValidator.email,
            label: s.key(Lk.email),
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),

          const VSpacer(Insets.l),

          ValidatableTextField(
            label: s.key(Lk.password),
            prefixIcon: Icons.password_rounded,
            autofillHints: const [AutofillHints.password],
            keyboardType: TextInputType.visiblePassword,
            validator: TextValidator.notEmpty,
            textInputAction: TextInputAction.done,
            controller: passwordController,
            margin: AppPadding.horizontal,
          ),
        ],
      ),
    );
  }
}
