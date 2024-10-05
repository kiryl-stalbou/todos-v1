import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../utils/common/desktop_constraints.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../../utils/mixins/theme_state_mixin.dart';
import '../../../_widgets/appbars/static_appbar.dart';
import '../../../_widgets/common/paddings.dart';
import '../../../_widgets/common/spacers.dart';
import '../../../_widgets/scaffolds/app_scaffold.dart';
import '../_widgets/signout_button.dart';
import '../_widgets/user_info.dart';
import '../user_profile_controller.dart';

class WebUserProfileScreen extends StatefulWidget {
  const WebUserProfileScreen({super.key});

  @override
  State<WebUserProfileScreen> createState() => _WebUserProfileScreenState();
}

class _WebUserProfileScreenState extends State<WebUserProfileScreen> with UserProfileController, ThemeStateMixin, LocalizationStateMixin {
  @override
  Widget build(BuildContext context) => AppScaffold(
        top: const StaticAppBar(),
        body: Center(
          child: DesktopConstraints(
            maxWidth: 400,
            child: AppPadding(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  UserInfo(user: user),

                  const VSpacer(Insets.xl),

                  SignOutButton(onTap: onSignOutTap),
                ],
              ),
            ),
          ),
        ),
      );
}
