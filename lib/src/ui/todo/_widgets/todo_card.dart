import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/curves.dart';
import '../../../constants/durations.dart';
import '../../../constants/sizes.dart';
import '../../../entities/todo/todo_data.dart';
import '../../../l10n/lk.dart';
import '../../../l10n/s.dart';
import '../../../scopes/user/dependencies/todos/todos.dart';
import '../../../utils/common/debouncer.dart';
import '../../../utils/common/hide_scrollbar.dart';
import '../../../utils/common/pick_date.dart';
import '../../../utils/mixins/ensure_visible.dart';
import '../../../utils/mixins/localization_state_mixin.dart';
import '../../../utils/mixins/theme_state_mixin.dart';
import '../../_widgets/common/spacers.dart';

enum TodoCardMode { drag, delete }

class TodoCard extends StatefulWidget {
  const TodoCard({
    required this.index,
    required this.todo,
    required this.mode,
    super.key,
  });

  final int index;
  final TodoData todo;
  final ValueNotifier<TodoCardMode?> mode;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late final _d = Debouncer(duration: const Duration(milliseconds: 500));
  late bool _isCompleted = widget.todo.isCompleted;

  void _onCompletedChanged(bool value) {
    setState(() => _isCompleted = value);
    _d.run(() {
      if (!mounted) return;
      Todos.of(context).update(
        widget.todo,
        widget.todo.copyWith(isCompleted: value),
      );
    });
    // ignore: discarded_futures
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _CompleteToggle(_onCompletedChanged, _isCompleted),

          Expanded(child: _Info(widget.todo, _isCompleted)),

          _ActionButton(widget.todo, widget.index, widget.mode),

          // Makes sure that web scroll bar doesn't overlap components
          if (kIsWeb) const HSpacer(Insets.l),
        ],
      );
}

class _CompleteToggle extends StatelessWidget {
  const _CompleteToggle(this.onChanged, this.isCompleted);

  final void Function(bool) onChanged;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    Widget checkbox = Checkbox(
      value: isCompleted,
      onChanged: (value) => onChanged(value ?? false),
    );

    if (!kIsWeb) checkbox = Transform.scale(scale: 1.25, child: checkbox);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xs),
      child: checkbox,
    );
  }
}

class _Info extends StatefulWidget {
  const _Info(this.todo, this.isCompleted);

  final TodoData todo;
  final bool isCompleted;

  @override
  State<_Info> createState() => _InfoState();
}

class _InfoState extends State<_Info> with ThemeStateMixin, LocalizationStateMixin {
  late final _titleController = TextEditingController(text: widget.todo.title);
  late final _notesController = TextEditingController(text: widget.todo.notes);
  late final _d = Debouncer(duration: const Duration(milliseconds: 300));

  void _onChanged(String text) => _d.run(() {
        if (!mounted) return;
        Todos.of(context).update(
          widget.todo,
          widget.todo.copyWith(
            title: _titleController.text,
            notes: _notesController.text,
          ),
        );
      });

  @override
  void didUpdateWidget(covariant _Info oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo != widget.todo) {
      _titleController.text = widget.todo.title ?? '';
      _notesController.text = widget.todo.notes ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.isCompleted ? -0.3 : 0.0;
    final style = textTheme.labelMedium?.copyWith(height: 1);
    final titleColor = colorScheme.onSurface.withOpacity(1 + f);
    final notesColor = colorScheme.onSurface.withOpacity(0.6 + f);
    final dateColor = colorScheme.secondary.withOpacity(1 + f);

    return ScrollConfiguration(
      behavior: const HideScrollbarBehavior(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          const VSpacer(kIsWeb ? Insets.l : Insets.s),

          TextField(
            maxLines: null,
            style: style?.copyWith(color: titleColor),
            onChanged: _onChanged,
            controller: _titleController,
            keyboardType: TextInputType.multiline,
            onTap: () async => ensureTextFieldVisible(context),
            decoration: InputDecoration.collapsed(
              hintText: s.key(Lk.title),
              hintStyle: style?.copyWith(color: titleColor),
            ),
          ),

          const VSpacer(kIsWeb ? Insets.m : Insets.xs),

          TextField(
            minLines: 1,
            maxLines: 10,
            onChanged: _onChanged,
            controller: _notesController,
            keyboardType: TextInputType.multiline,
            style: style?.copyWith(color: notesColor),
            onTap: () async => ensureTextFieldVisible(context),
            decoration: InputDecoration.collapsed(
              hintStyle: style?.copyWith(color: notesColor),
              hintText: s.key(Lk.notes),
            ),
          ),

          const VSpacer(kIsWeb ? Insets.s : Insets.xs),

          _DatePicker(widget.todo, style?.copyWith(color: dateColor)),

          const VSpacer(kIsWeb ? Insets.m : Insets.s),

          const Divider(thickness: Strokes.thin, height: 0),
        ],
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker(this.todo, this.style);

  final TodoData todo;
  final TextStyle? style;

  Future<void> _pickDate(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null || !context.mounted) return;
    Todos.of(context).update(todo, todo.copyWith(date: date));
  }

  @override
  Widget build(BuildContext context) {
    final date = todo.date;
    final s = S.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async => _pickDate(context),
        child: Text(
          date == null ? s.key(Lk.pickDate) : '${date.day}.${date.month}.${date.year % 100}',
          style: style,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton(this.todo, this.index, this.mode);

  final int index;
  final TodoData todo;
  final ValueNotifier<TodoCardMode?> mode;

  void _onDeleteTap(BuildContext context) => Todos.of(context).delete(todo);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: AppDurations.fastSlide,
      curve: AppCurves.slide,
      child: ListenableBuilder(
        listenable: mode,
        builder: (_, __) {
          final value = mode.value;

          if (value == null) return const SizedBox.shrink();

          return switch (value) {
            TodoCardMode.drag => ReorderableDragStartListener(
                index: index,
                child: const SizedBox.square(
                  dimension: kMinInteractiveDimension,
                  child: Icon(Icons.drag_handle_rounded),
                ),
              ),
            TodoCardMode.delete => IconButton(
                icon: Icon(Icons.delete_outline_rounded, color: colorScheme.error),
                onPressed: () => _onDeleteTap(context),
                color: colorScheme.error,
              ),
          };
        },
      ),
    );
  }
}
