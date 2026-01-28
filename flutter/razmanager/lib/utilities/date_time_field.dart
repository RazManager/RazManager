import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'date_formatter.dart';

class DateTimeField extends StatelessWidget with DateFormatter {
  const DateTimeField(
      {super.key, required FormGroup formGroup, required String formControlName, required String labelText, required Duration duration, required bool required})
      : _formGroup = formGroup,
        _formControlName = formControlName,
        _labelText = labelText,
        _duration = duration,
        _required = required;

  final FormGroup _formGroup;
  final String _formControlName;
  final String _labelText;
  final Duration _duration;
  final bool _required;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      final value = _formGroup.control(_formControlName).value as DateTime?;
      final now = DateTime.now();
      return TextField(
        readOnly: true,
        controller: value == null ? TextEditingController(text: '') : TextEditingController(text: dateTimeFormat(value)),
        decoration: InputDecoration(
            prefixIcon: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  final result = await showDatePicker(
                      context: context, initialDate: value == null || value.isBefore(now) ? null : value, firstDate: now, lastDate: now.add(_duration));
                  if (result != null) {
                    setState(() {
                      _formGroup.control(_formControlName).value = result;
                      _formGroup.control(_formControlName).markAsDirty();
                    });
                  }
                }),
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
            labelText: _labelText),
      );
    });
  }
}
