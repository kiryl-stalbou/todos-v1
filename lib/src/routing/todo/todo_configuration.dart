enum TodoTab { all, completed, today, profile }

final class TodoConfiguration {
  const TodoConfiguration({required this.selectedTab});

  const TodoConfiguration.empty() : selectedTab = TodoTab.all;

  factory TodoConfiguration.fromUri(Uri uri) {
    if (uri.pathSegments.length > 1) {
      return TodoConfiguration(
        selectedTab: switch (uri.pathSegments[1]) {
          'completed' => TodoTab.completed,
          'today' => TodoTab.today,
          'profile' => TodoTab.profile,
          _ => TodoTab.all,
        },
      );
    }

    return const TodoConfiguration.empty();
  }

  final TodoTab selectedTab;

  Uri toUri() => Uri.parse('/todos/${selectedTab.name}');

  @override
  String toString() => 'TodoConfig(selectedTab: $selectedTab)';
}
