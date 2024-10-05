import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;

import '../logs/logger.dart';

/// Localized resources object.
final class S {
  const S._(this._locale, this._localizationByKey);

  static const supportedLocales = [Locale('en'), Locale('ru')];
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _CustomLocalizationsDelegate(),
  ];

  static S of(BuildContext context) {
    final localizations = Localizations.of<S>(context, S);

    if (localizations == null) throw Exception('Invalid context: Missing _LocalizationsScope');

    return localizations;
  }

  final Locale _locale;
  Locale get locale => _locale;

  final Map<String, String> _localizationByKey;

  static const _l = Logger(library: 'lib/src/l10n/s.dart');

  /// Returns localized string corresponding to
  /// the provided [localizationKey].
  ///
  /// Otherwise returns empty [String].
  String key(String localizationKey) {
    late final l = _l.copyWith(method: 'key', params: 'localizationKey: $localizationKey', logOnCopy: false);

    final localization = _localizationByKey[localizationKey];

    if (localization == null) l.w('Localization missing for key: $localizationKey');

    return localization ?? '';
  }
}

final class _CustomLocalizationsDelegate extends LocalizationsDelegate<S> {
  const _CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => S.supportedLocales.contains(locale);

  static final Map<Locale, Future<S>> _cachedLocalizations = {};

  @override
  Future<S> load(Locale locale) => _cachedLocalizations.putIfAbsent(locale, () async {
        final string = await rootBundle.loadString('lib/src/l10n/jsons/${locale.languageCode}.json');

        final localizationByKey = (jsonDecode(string) as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String));

        return S._(locale, localizationByKey);
      });

  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}
