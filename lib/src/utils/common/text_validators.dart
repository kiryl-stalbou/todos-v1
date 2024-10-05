import '../../l10n/lk.dart';

enum TextValidator { notEmpty, email }

String clearSpaces(String rawText) => rawText.replaceAll(' ', '');

/// Returns null if valid, otherwise returns localized error string
String? validateNotEmpty(String? rawText) {
  final text = clearSpaces(rawText ?? '');

  if (text.isEmpty) return Lk.require;

  return null;
}

/// Returns null if valid, otherwise returns localized error string
String? validateEmail(String? rawText) {
  final email = clearSpaces(rawText ?? '');

  if (email.isEmpty) return Lk.require;

  final regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  if (regExp.hasMatch(email)) return null;

  return Lk.errorInvalidEmail;
}
