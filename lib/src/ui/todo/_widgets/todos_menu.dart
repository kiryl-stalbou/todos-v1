import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../../_widgets/common/spacers.dart';
import 'todo_card.dart';

class TodosMenu extends StatelessWidget {
  const TodosMenu({
    required this.mode,
    this.onAddTodoTap,
    super.key,
  });

  final ValueNotifier<TodoCardMode?> mode;
  final VoidCallback? onAddTodoTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return PopupMenuButton<void>(
      icon: const Icon(Icons.settings_rounded),
      itemBuilder: (_) => <PopupMenuEntry<void>>[
        if (onAddTodoTap != null)
          _PopUpItem(
            onTap: () => onAddTodoTap?.call(),
            icon: Icons.add,
            label: s.key(Lk.addTodo),
          ),
        _PopUpItem(
          onTap: () => mode.value = null,
          icon: Icons.restore,
          label: s.key(Lk.restoreMode),
        ),
        _PopUpItem(
          onTap: () => mode.value = TodoCardMode.drag,
          icon: Icons.drag_handle_rounded,
          label: s.key(Lk.dragMode),
        ),
        _PopUpItem(
          onTap: () => mode.value = TodoCardMode.delete,
          icon: Icons.delete_outline_rounded,
          label: s.key(Lk.deleteMode),
        ),
      ],
    );
  }
}

class _PopUpItem extends PopupMenuEntry<void> {
  const _PopUpItem({
    required this.onTap,
    required this.icon,
    required this.label,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String label;

  @override
  State<_PopUpItem> createState() => _PopUpItemState();

  @override
  double get height => 0;

  @override
  bool represents(void value) => false;
}

class _PopUpItemState extends State<_PopUpItem> {
  @override
  Widget build(BuildContext context) => PopupMenuItem<void>(
        onTap: widget.onTap,
        child: Row(
          children: [
            //
            Icon(widget.icon),

            const HSpacer(Insets.xs),

            Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
}
