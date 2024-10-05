import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/common/text_validators.dart';
import '../../../../utils/mixins/localization_state_mixin.dart';
import '../../../../utils/mixins/theme_state_mixin.dart';
import '../../animated/animated_error_text.dart';
import '../app_text_field.dart';
import '_validatable_state.dart';
import 'validatable_form.dart';

class ValidatableTextField extends StatefulWidget {
  const ValidatableTextField({
    required this.label,
    required this.validator,
    required this.controller,
    required this.margin,
    this.autofocus = false,
    this.maxLength = 30,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.autofillHints,
    super.key,
  });

  final String label;
  final int maxLength;
  final bool autofocus;
  final EdgeInsets margin;
  final TextValidator validator;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ValidatableTextField> createState() => ValidatableTextFieldState();
}

class ValidatableTextFieldState extends ValidatableState<ValidatableTextField> with LocalizationStateMixin, ThemeStateMixin {
  String? _errorLk;

  void _onChanged(String text) {
    if (_errorLk != null) setState(() => _errorLk = null);
  }

  @override
  bool isValid() {
    final text = widget.controller.text;

    setState(
      () => _errorLk = switch (widget.validator) {
        TextValidator.notEmpty => validateNotEmpty(text),
        TextValidator.email => validateEmail(text),
      },
    );

    return _errorLk == null;
  }

  @override
  void initState() {
    super.initState();
    ValidatableForm.of(context).register(this);
  }

  @override
  Widget build(BuildContext context) => AnimatedErrorText(
        errorLk: _errorLk,
        margin: widget.margin,
        child: AppTextField(
          label: widget.label,
          onChanged: _onChanged,
          hasError: _errorLk != null,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          prefixIcon: widget.prefixIcon,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
        ),
      );
}
