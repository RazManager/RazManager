import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  Color themeDataColorSchemeSeed = Colors.teal;
  Brightness themeDataBrightness = Brightness.dark;

  void setThemeDataColorSchemeSeed(Color? value) {
    themeDataColorSchemeSeed = value as Color;
    notifyListeners();
  }

  void setThemeDataBrightness(Brightness? value) {
    themeDataBrightness = value as Brightness;
    notifyListeners();
  }
}
