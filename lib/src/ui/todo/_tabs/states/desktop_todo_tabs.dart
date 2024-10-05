import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../l10n/lk.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../_widgets/scaffolds/scroll_aware_scaffold.dart';
import '../../_widgets/today_badge.dart';
import '../tabs_controller.dart';

class DesktopTodoTabs extends StatefulWidget {
  const DesktopTodoTabs({super.key});

  @override
  State<DesktopTodoTabs> createState() => _DesktopTodoTabsState();
}

class _DesktopTodoTabsState extends State<DesktopTodoTabs> with LocalizationStateMixin, TodoTabsController {
  @override
  Widget build(BuildContext context) => ScrollAwareScaffold(
        body: Row(
          children: <Widget>[
            //
            NavigationRail(
              selectedIndex: selectedTabIndex,
              onDestinationSelected: onTabTap,
              labelType: NavigationRailLabelType.all,
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Icons.all_inbox_outlined),
                  selectedIcon: const Icon(Icons.all_inbox_rounded),
                  padding: const EdgeInsets.symmetric(vertical: Insets.xs),
                  label: Text(s.key(Lk.all)),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.done_all_outlined),
                  selectedIcon: const Icon(Icons.done_all_rounded),
                  label: Text(s.key(Lk.completed)),
                  padding: const EdgeInsets.symmetric(vertical: Insets.xs),
                ),
                NavigationRailDestination(
                  icon: const TodayBadge(child: Icon(Icons.today_outlined)),
                  selectedIcon: const TodayBadge(child: Icon(Icons.today_rounded)),
                  label: Text(s.key(Lk.today)),
                  padding: const EdgeInsets.symmetric(vertical: Insets.xs),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person_rounded),
                  label: Text(s.key(Lk.profile)),
                  padding: const EdgeInsets.symmetric(vertical: Insets.xs),
                ),
              ],
            ),

            const VerticalDivider(thickness: 0.5, width: 0.5),

            Expanded(child: tabsViews[selectedTabIndex]),
          ],
        ),
      );
}
