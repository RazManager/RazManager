import 'package:flutter/material.dart';
import 'package:razmanager/utilities/color_definitions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  Color themeDataColorSchemeSeed = Colors.teal;
  Brightness themeDataBrightness = Brightness.dark;

  SettingsModel() {
    Future.microtask(() async {
      final sharedPreferences = await SharedPreferences.getInstance();

      final themeDataColorSchemeSeedValue = sharedPreferences.getInt('themeDataColorSchemeSeed');
      if (themeDataColorSchemeSeedValue == null) {
        themeDataColorSchemeSeed = Colors.teal;
      } else {
        var color = ColorDefinitions.primaries.where((x) => x.color.toARGB32() == themeDataColorSchemeSeedValue).singleOrNull?.color;
        if (color != null) {
          themeDataColorSchemeSeed = color;
        }
      }

      final themeDataBrightnessValue = sharedPreferences.getString('themeDataBrightness');
      if (themeDataBrightnessValue == null) {
        themeDataBrightness = Brightness.dark;
      } else {
        themeDataBrightness = Brightness.values.byName(themeDataBrightnessValue);
      }
      notifyListeners();
    });
  }

  Future<void> setThemeDataColorSchemeSeed(Color value) async {
    themeDataColorSchemeSeed = value;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('themeDataColorSchemeSeed', value.toARGB32());

    notifyListeners();
  }

  Future<void> setThemeDataBrightness(Brightness value) async {
    themeDataBrightness = value;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('themeDataBrightness', value.name);

    notifyListeners();
  }
}
