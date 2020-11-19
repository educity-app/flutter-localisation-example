import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Define supported locales variable
final supportedLocales = [
  Locale('en'),
  Locale('es')
];

/// App localization delegate
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  /// Initializing the delegate
  const _AppLocalizationsDelegate();

  /// Check if language is supported
  @override
  bool isSupported(Locale locale) {
    /// Add the two-letter code of
    /// supported locales here
    return ["en", "es"].contains(locale.languageCode);
  }

  /// AppLocalizations class where JSON is loaded
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}


/// Translate Function
translate(key, context) {
  return AppLocalizations.of(context).localizedStrings["$key"];
}

class AppLocalizations {
  final Locale locale;

  /// Initialize
  AppLocalizations(this.locale);
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Delegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  /// Loads the language file
  Map<String, String> localizedStrings;
  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }
}

