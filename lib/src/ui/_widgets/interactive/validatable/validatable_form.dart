import 'package:flutter/widgets.dart';

import '_validatable_state.dart';

class ValidatableForm extends StatefulWidget {
  const ValidatableForm({required this.child, required super.key});

  final Widget child;

  static ValidatableFormState of(BuildContext context) {
    final state = context.findAncestorStateOfType<ValidatableFormState>();

    if (state == null) throw Exception('Invalid context: Missing ValidatableForm');

    return state;
  }

  @override
  State<ValidatableForm> createState() => ValidatableFormState();
}

class ValidatableFormState extends State<ValidatableForm> {
  final Set<ValidatableState> _elements = {};

  void register(ValidatableState element) => _elements.add(element);

  bool validate() {
    bool isValid = true;

    for (final element in _elements) {
      if (!element.isValid()) isValid = false;
    }

    return isValid;
  }

  @override
  void dispose() {
    _elements.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
