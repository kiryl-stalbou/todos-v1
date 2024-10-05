import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../utils/mixins/ensure_visible.dart';
import '../../../utils/mixins/focus_state_mixin.dart';
import '../../../utils/mixins/theme_state_mixin.dart';
import 'clear_button.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 30,
    this.autofocus = false,
    this.readOnly = false,
    this.hasError = false,
    this.prefixIcon,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.margin,
    this.autofillHints,
    super.key,
  });

  final String label;
  final int minLines;
  final int maxLines;
  final bool readOnly;
  final bool autofocus;
  final bool hasError;
  final int maxLength;
  final EdgeInsets? margin;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with ThemeStateMixin, Focus1StateMixin {
  late final _effectiveController = widget.controller ?? TextEditingController();

  @override
  bool get canRequestFocus => !widget.readOnly;

  @override
  void onFocusChanged() {
    setState(() {});
    // ignore: discarded_futures
    if (hasFocus) ensureTextFieldVisible(context, focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = theme.inputDecorationTheme.labelStyle;

    final borderWidth = hasFocus ? Strokes.thick : Strokes.mid;

    final cursorColor = widget.hasError ? colorScheme.error : null;
    final overlayColor = widget.readOnly ? AppColors.grey26 : null;
    final borderColor = widget.hasError ? colorScheme.error : (hasFocus ? colorScheme.primary : AppColors.grey26);
    final labelColor = widget.hasError ? colorScheme.error : (hasFocus ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.5));

    final prefixIcon = widget.prefixIcon != null ? Icon(widget.prefixIcon, color: labelColor) : null;
    final suffixIcon = widget.readOnly ? null : ClearButton(controller: _effectiveController);

    Widget body = RepaintBoundary(
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: Corners.sBorderRadius,
          color: overlayColor,
        ),
        child: TextField(
          style: labelStyle,
          buildCounter: null,
          focusNode: focusNode,
          cursorColor: cursorColor,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          enabled: !widget.readOnly,
          readOnly: widget.readOnly,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus,
          controller: _effectiveController,
          canRequestFocus: !widget.readOnly,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            counterText: '',
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: widget.label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: labelStyle?.copyWith(color: labelColor),
            contentPadding: const EdgeInsets.symmetric(horizontal: Insets.m, vertical: 6),
          ),
        ),
      ),
    );

    final margin = widget.margin;
    if (margin != null) body = Padding(padding: margin, child: body);

    return body;
  }
}
