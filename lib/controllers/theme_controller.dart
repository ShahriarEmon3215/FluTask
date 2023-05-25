import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  //brightness: Brightness.light,
  useMaterial3: true,
  primarySwatch: Colors.indigo,
  textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo),
      displayMedium: TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo)),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.indigo,
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  //brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo),
    displayMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? prefs;
  bool? _darkTheme;

  bool? get darkTheme => _darkTheme!; //Getter

  ThemeNotifier() {
    _darkTheme = false;
    loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme!;
    saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    prefs!.getBool(key) ?? await prefs!.setBool(key, true); 
    _darkTheme = prefs!.getBool(key) ?? false;
    notifyListeners();
  }

  saveToPrefs() async {
    await _initPrefs();
    prefs!.setBool(key, darkTheme!);
  }
}
