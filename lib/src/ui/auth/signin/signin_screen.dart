import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'states/mobile_signin_screen.dart';
import 'states/web_signin_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const WebSignInScreen();

    return const MobileSignInScreen();
  }
}
