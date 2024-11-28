import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, BANGLA }

const String BANGLA = "bn";
const String ENGLISH = "en";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale BANGLA_LOCAL = Locale("bn","BD");
const Locale ENGLISH_LOCAL = Locale("en","US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.BANGLA:
        return BANGLA;
    }
  }
}
