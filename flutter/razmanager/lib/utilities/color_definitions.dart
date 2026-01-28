import 'package:flutter/material.dart';

enum ColorDefinitionType { accent, primary, other }

class ColorDefinition {
  ColorDefinition({required this.color, required this.name, required this.colorDefinitionType});
  final Color color;
  final String name;
  final ColorDefinitionType colorDefinitionType;

  static ColorDefinition fromColor(int value) {
    return ColorDefinitions.all.singleWhere((x) => x.color.value == value);
  }
}

class ColorDefinitions {
  static Iterable<ColorDefinition> all = [
    ColorDefinition(color: Colors.redAccent, name: "Bright red", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.pinkAccent, name: "Bright pink", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.purpleAccent, name: "Bright purple", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(
        color: Colors.deepPurpleAccent, name: "Bright deep purple", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.indigoAccent, name: "Bright indigo", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.blueAccent, name: "Bright blue", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(
        color: Colors.lightBlueAccent, name: "Bright light blue", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.cyanAccent, name: "Bright cyan", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.tealAccent, name: "Bright teal", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.greenAccent, name: "Bright green", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(
        color: Colors.lightGreenAccent, name: "Bright light green", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.limeAccent, name: "Bright lime", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.yellowAccent, name: "Bright yellow", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.amberAccent, name: "Bright amber", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.orangeAccent, name: "Bright orange", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(
        color: Colors.deepOrangeAccent, name: "Bright deep orange", colorDefinitionType: ColorDefinitionType.accent),
    ColorDefinition(color: Colors.red, name: "Red", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.pink, name: "Pink", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.purple, name: "Purple", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.deepPurple, name: "Deep purple", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.indigo, name: "Indigo", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.blue, name: "Blue", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.lightBlue, name: "Light blue", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.cyan, name: "Cyan", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.teal, name: "Teal", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.green, name: "Green", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.lightGreen, name: "Light green", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.lime, name: "Lime", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.yellow, name: "Yellow", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.amber, name: "Amber", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.orange, name: "Orange", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.deepOrange, name: "Deep orange", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.brown, name: "Brown", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.blueGrey, name: "Blue grey", colorDefinitionType: ColorDefinitionType.primary),
    ColorDefinition(color: Colors.white, name: "White", colorDefinitionType: ColorDefinitionType.other),
    ColorDefinition(color: Colors.grey, name: "Grey", colorDefinitionType: ColorDefinitionType.other),
    ColorDefinition(color: Colors.black, name: "Black", colorDefinitionType: ColorDefinitionType.other),
  ];

  static Iterable<ColorDefinition> accents = all.where((x) => x.colorDefinitionType == ColorDefinitionType.accent);

  static Iterable<ColorDefinition> primaries = all.where((x) => x.colorDefinitionType == ColorDefinitionType.primary);

  static Iterable<ColorDefinition> others = all.where((x) => x.colorDefinitionType == ColorDefinitionType.other);

  static Iterable<Color> ordered = [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
        Colors.orangeAccent,
        Colors.white,
        Colors.purpleAccent,
        Colors.grey,
        Colors.blueGrey,
        Colors.brown,
        Colors.cyanAccent,
        Colors.lightGreenAccent,
        Colors.lightBlueAccent,
        Colors.indigoAccent,
        Colors.deepOrangeAccent,
        Colors.pinkAccent,
        Colors.deepPurpleAccent,
        Colors.tealAccent,
        Colors.limeAccent,
        Colors.amberAccent
 ];

}