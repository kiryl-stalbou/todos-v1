import 'package:flutter/material.dart' show FocusManager;

void hideKeyBoard() => FocusManager.instance.primaryFocus?.unfocus();
