import 'package:flutter/material.dart';

class ClearButton extends StatefulWidget {
  const ClearButton({
    required this.controller,
    this.icon = Icons.cancel_rounded,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final TextEditingController controller;

  @override
  State<ClearButton> createState() => _ClearButtonState();
}

class _ClearButtonState extends State<ClearButton> {
  late bool _showButton;

  void _onClearTap() => setState(() {
        _showButton = false;
        widget.onTap?.call();
        widget.controller.clear();
      });

  void _onTextChanged() {
    if (_showButton ^ widget.controller.text.isNotEmpty) {
      setState(() => _showButton = !_showButton);
    }
  }

  @override
  void initState() {
    super.initState();
    _showButton = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _showButton
      ? IconButton(
          icon: Icon(widget.icon),
          onPressed: _onClearTap,
        )
      : const SizedBox.shrink();
}
