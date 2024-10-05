import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../_widgets/common/paddings.dart';
import '../../_widgets/common/spacers.dart';
import '../../_widgets/scaffolds/app_scaffold.dart';

class DebugErrorScreen extends StatelessWidget {
  const DebugErrorScreen(this.errors, {super.key});

  final List<(Object, StackTrace)> errors;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final style = textTheme.labelSmall?.copyWith(color: colorScheme.onError);

    return AppScaffold(
      color: colorScheme.error,
      body: AppPadding(
        child: ListView.separated(
          itemCount: errors.length,
          separatorBuilder: (_, index) => Divider(color: colorScheme.onError, height: Insets.xxl),
          itemBuilder: (_, index) => Column(
            children: [
              //
              Text(errors[index].$1.toString(), style: style),

              const VSpacer(Insets.m),

              Text(errors[index].$2.toString(), style: style),
            ],
          ),
        ),
      ),
    );
  }
}
