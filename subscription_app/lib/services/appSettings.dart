import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'languages.dart';

class AppSettings extends ChangeNotifier {
  Map<String, String> _translatedStrings;
  String langCode = 'en';

  set lang(String newLang) {
    langCode = newLang;
    changeLanguage();
  }

  AppSettings() {
    changeLanguage();
  }

  void changeLanguage() {
    _translatedStrings = Language.load(langCode);
    print(_translatedStrings);
    notifyListeners();
  }

  String multiLangString(String key) {
    return _translatedStrings[key];
  }
}
