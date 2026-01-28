import 'package:flutter/material.dart';

import 'color_definitions.dart';

mixin ColorDefinitionPicker {
  Future<ColorDefinition?> pick(BuildContext context) {
    return showDialog<ColorDefinition>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select a color'),
            content: Column(
              children: [
                const Text('Bright colors'),
                _colorDefinitionTable(context, ColorDefinitions.accents),
                const Text('Other colors'),
                _colorDefinitionTable(context, ColorDefinitions.others),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _colorDefinitionTable(BuildContext context, Iterable<ColorDefinition> colorDefinitions) {
    const columns = 4;
    return Table(children: [
      for (int row = 0; row < colorDefinitions.length / columns; row++)
        TableRow(children: [
          for (int column = 0; column < columns; column++)
            if (row * columns + column <= colorDefinitions.length - 1)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(colorDefinitions.toList()[row * columns + column]);
                },
                child: CircleAvatar(
                  backgroundColor: colorDefinitions.toList()[row * columns + column].color,
                ),
              )
            else
              const Text('s'),
        ])
    ]);
  }
}
