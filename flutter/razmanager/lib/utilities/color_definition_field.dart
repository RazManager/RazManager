import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'color_definition_picker.dart';
import 'color_definitions.dart';

class ColorDefinitionField extends StatelessWidget with ColorDefinitionPicker {
  const ColorDefinitionField(
      {super.key,
      required FormGroup formGroup,
      required String formControlName,
      required bool required})
      : _formGroup = formGroup,
        _formControlName = formControlName,
        _required = required;

  final FormGroup _formGroup;
  final String _formControlName;
  final bool _required;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      final value = _formGroup.control(_formControlName).value as int?;
      ColorDefinition? colorDefinition;
      if (value != null) {
        colorDefinition = ColorDefinition.fromColor(value);
      }

      return TextField(
        readOnly: true,
        controller: colorDefinition == null
            ? TextEditingController(text: '')
            : TextEditingController(text: colorDefinition.name),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              icon: const Icon(Icons.palette),
              onPressed: () async {
                final result = await pick(context);
                if (result != null) {
                  setState(() {
                    _formGroup.control(_formControlName).value =
                        result.color.value;
                    _formGroup.control(_formControlName).markAsDirty();
                  });
                }
              }),
          prefix: _formGroup.control(_formControlName).value == null
              ? null
              : CircleAvatar(
                  backgroundColor:
                      Color(_formGroup.control(_formControlName).value)),
          suffixIcon: _required
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _formGroup.control(_formControlName).value = null;
                      _formGroup.control(_formControlName).markAsDirty();
                    });
                  }),
        ),
      );
    });
  }
}
