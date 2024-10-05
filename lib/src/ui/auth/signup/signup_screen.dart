import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'states/mobile_signup_screen.dart';
import 'states/web_signup_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const WebSignUpScreen();

    return const MobileSignUpScreen();
  }
}
