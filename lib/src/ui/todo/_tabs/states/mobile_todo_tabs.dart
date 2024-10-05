import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/durations.dart';
import '../../../../l10n/lk.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../_widgets/scaffolds/scroll_aware_scaffold.dart';
import '../../_widgets/today_badge.dart';
import '../tabs_controller.dart';

class MobileTodoTabs extends StatefulWidget {
  const MobileTodoTabs({super.key});

  @override
  State<MobileTodoTabs> createState() => _MobileTodoTabsState();
}

class _MobileTodoTabsState extends State<MobileTodoTabs> with LocalizationStateMixin, TodoTabsController {
  @override
  Widget build(BuildContext context) => ScrollAwareScaffold(
        body: tabsViews[selectedTabIndex],
        bottom: DecoratedBox(
          decoration: const BoxDecoration(boxShadow: Shadows.top),
          child: NavigationBar(
            onDestinationSelected: onTabTap,
            selectedIndex: selectedTabIndex,
            animationDuration: AppDurations.navigationBarAnimation,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.all_inbox_outlined),
                selectedIcon: const Icon(Icons.all_inbox_rounded),
                label: s.key(Lk.all),
              ),
              NavigationDestination(
                icon: const Icon(Icons.done_all_outlined),
                selectedIcon: const Icon(Icons.done_all_rounded),
                label: s.key(Lk.completed),
              ),
              NavigationDestination(
                icon: const TodayBadge(child: Icon(Icons.today_outlined)),
                selectedIcon: const TodayBadge(child: Icon(Icons.today_rounded)),
                label: s.key(Lk.today),
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person_rounded),
                label: s.key(Lk.profile),
              ),
            ],
          ),
        ),
      );
}
