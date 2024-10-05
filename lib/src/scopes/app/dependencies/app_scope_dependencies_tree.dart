import 'package:flutter/widgets.dart';

class AppScopeDependenciesTree extends StatelessWidget {
  const AppScopeDependenciesTree({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
