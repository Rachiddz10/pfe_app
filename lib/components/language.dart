import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Language {
  static Locale language = const Locale('en');

  static void setLanguage (Locale s) {
    language = s;
  }

  static Future<Translation> getTranslation(String s) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(s, from: 'en', to: 'it');
    return translation;
  }
}