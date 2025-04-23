import 'package:flutter/material.dart';

class Language {
  Locale locale;
  String language;
  final String countryCode;

  Language({
    required this.locale,
    required this.language,
    required this.countryCode
});
}

List<Language> languageList = [
  Language(
      locale: const Locale('en'),
      language: 'English - UK',
      countryCode: 'GB'
  ),
  Language(
      locale: const Locale('pl'),
      language: 'Polski - PL',
      countryCode: 'PL'
  ),
  Language(
      locale: const Locale('ru'),
      language: 'Russian - Ru',
      countryCode: 'RU'
  ),
];