import 'package:flutter/cupertino.dart';
import 'package:pokemon/model/DarkThemePreference.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool val){
    _darkTheme = val;
    darkThemePreference.setDarkTheme(val);
    notifyListeners();
  }
}