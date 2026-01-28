import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ImageAvatarField extends StatelessWidget {
  const ImageAvatarField({super.key, required FormGroup formGroup, required Future<Uint8List?> Function(BuildContext, FormGroup) pickImage })
      : _formGroup = formGroup, _pickImage = pickImage;

  final FormGroup _formGroup;
 final Future<Uint8List?> Function(BuildContext, FormGroup) _pickImage;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      final value = _formGroup.control('image').value as Uint8List?;

      return TextField(
        readOnly: true,
        controller: TextEditingController(text: ''),
        decoration: InputDecoration(
          prefixIcon: IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () async {
                final result = await _pickImage(context, _formGroup);
                  setState(() {
                });

                // if (result != null) {
                //   setState(() {
                //     _formGroup.control("image").value = result;
                //     _formGroup.control("image").markAsDirty();
                //   });
                // }
              }),
          prefix: _formGroup.control('image').value == null
              ? null
              : CircleAvatar(foregroundImage: MemoryImage(value!)),
          suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _formGroup.control('image').value = null;
                  _formGroup.control('imageDeleted').value = true;
                  _formGroup.control('imageDeleted').markAsDirty();
                });
              }),
        ),
      );
    });
  }
}
