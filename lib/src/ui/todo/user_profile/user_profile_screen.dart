import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'states/mobile_user_profile_screen.dart';
import 'states/web_user_profile_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const WebUserProfileScreen();

    return const MobileUserProfileScreen();
  }
}
