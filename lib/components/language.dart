import 'package:flutter/material.dart';

class Language {
  static Locale language = const Locale('en');

  static void setLanguage (Locale s) {
    language = s;
  }
}