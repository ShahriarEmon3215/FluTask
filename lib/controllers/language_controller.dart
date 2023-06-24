import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/l10n/language_helper.dart';

class LanguageController with ChangeNotifier {
  String? currentLanguage;
  Locale? locale;
  SharedPreferences? prefs;


  LanguageHelper? languageHelper = LanguageHelper();

  getlocale() async {
    await _initPrefs();
    prefs!.getString('lang') ?? await prefs!.setString('lang', 'en');
    print(prefs!.getString('lang')!);
    locale = Locale(prefs!.getString('lang')!);
    return locale!;
  }

  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  void changeLocale(String newLocale) async {
    Locale convertedLocale;
    await _initPrefs();

    currentLanguage = newLocale;

    convertedLocale = languageHelper!.convertLangNameToLocale(newLocale);
    print(convertedLocale.languageCode);
    await prefs!.setString('lang', convertedLocale.languageCode);
    locale = convertedLocale;
    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String definedCurrentLanguage;

    if (currentLanguage != null)
      definedCurrentLanguage = currentLanguage!;
    else {
      print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      definedCurrentLanguage = languageHelper!
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }
}
