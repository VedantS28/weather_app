import "package:flutter/material.dart";

class ThemeProvider with ChangeNotifier
{
  ThemeData _currentTheme=ThemeData.light();
  ThemeData get currentTheme=>_currentTheme;

  set currentTheme(ThemeData currentTheme)
  {
    _currentTheme=currentTheme;
    notifyListeners();
  }

  void toggleTheme()
  {
    if (_currentTheme==ThemeData.light())
    {
      currentTheme=ThemeData.dark();
    }
    else
    {
      currentTheme=ThemeData.light();
    }
  }
}